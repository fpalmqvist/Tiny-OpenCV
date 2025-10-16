#!/bin/bash
set -e

# Build Tiny OpenCV with 16KB page alignment
# Only includes: core, imgproc, android (like original Tiny-OpenCV)

# Auto-detect or download OpenCV source
OPENCV_SOURCE="$HOME/opencv-4.4.0"

if [ ! -d "$OPENCV_SOURCE" ]; then
  echo "OpenCV source not found. Downloading..."
  cd "$HOME"
  wget -q --show-progress https://github.com/opencv/opencv/archive/4.4.0.zip -O opencv-4.4.0.zip
  unzip -q opencv-4.4.0.zip
  rm opencv-4.4.0.zip
  echo "✓ OpenCV source downloaded"
fi

# Auto-detect or download Android NDK
ANDROID_NDK="$HOME/android-ndk-r27"

if [ ! -d "$ANDROID_NDK" ]; then
  echo "Android NDK not found. Downloading NDK r27..."
  cd "$HOME"
  wget -q --show-progress https://dl.google.com/android/repository/android-ndk-r27-linux.zip -O ndk.zip
  echo "Extracting NDK (this may take a few minutes)..."
  unzip -q ndk.zip
  rm ndk.zip
  echo "✓ Android NDK downloaded"
fi

OUTPUT_DIR="$HOME/opencv_tiny_16kb_build"
PROJECT_DIR="/mnt/c/Source/Tiny-OpenCV"

ABIS=("arm64-v8a" "armeabi-v7a" "x86" "x86_64")
LINKER_FLAGS="-Wl,-z,max-page-size=16384"

echo "============================================"
echo "Building Tiny OpenCV 4.4.0 with 16KB Alignment"
echo "Only modules: core, imgproc, android"
echo "============================================"
echo "OpenCV Source: $OPENCV_SOURCE"
echo "Android NDK:   $ANDROID_NDK"
echo "Output Dir:    $OUTPUT_DIR"
echo "============================================"

mkdir -p "$OUTPUT_DIR"

for ABI in "${ABIS[@]}"; do
  echo ""
  echo "========================================"
  echo "Building for $ABI..."
  echo "========================================"
  
  ABI_BUILD_DIR="$OUTPUT_DIR/$ABI"
  rm -rf "$ABI_BUILD_DIR"
  mkdir -p "$ABI_BUILD_DIR"
  cd "$ABI_BUILD_DIR"
  
  # Patch the Java CMakeLists.txt to skip android_sdk subdirectory
  JAVA_CMAKE="$OPENCV_SOURCE/modules/java/CMakeLists.txt"
  if [ ! -f "$JAVA_CMAKE.bak" ]; then
    cp "$JAVA_CMAKE" "$JAVA_CMAKE.bak"
  fi
  sed -i 's/^  add_subdirectory(android_sdk)/#  add_subdirectory(android_sdk)/' "$JAVA_CMAKE"
  
  # Set required environment variables
  export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
  export ANT_EXECUTABLE="/usr/bin/ant"
  export ANDROID_SDK="$ANDROID_NDK"
  export ANDROID_HOME="$ANDROID_NDK"
  
  # Ensure Python is available (required for Java bindings generator)
  export PYTHON_DEFAULT_EXECUTABLE="$(which python3 || which python)"
  
  echo "Configuring CMake for $ABI..."
  cmake -G Ninja \
    -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
    -DANDROID_ABI="$ABI" \
    -DANDROID_PLATFORM=android-21 \
    -DANDROID_STL=c++_shared \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SHARED_LINKER_FLAGS="$LINKER_FLAGS" \
    -DCMAKE_EXE_LINKER_FLAGS="$LINKER_FLAGS" \
    -DBUILD_FAT_JAVA_LIB=ON \
    -DBUILD_opencv_java=ON \
    -DJAVA_HOME="$JAVA_HOME" \
    -DANT_EXECUTABLE="$ANT_EXECUTABLE" \
    -DPYTHON_DEFAULT_EXECUTABLE="$PYTHON_DEFAULT_EXECUTABLE" \
    -DBUILD_ANDROID_PROJECTS=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_opencv_apps=OFF \
    -DBUILD_opencv_python2=OFF \
    -DBUILD_opencv_python3=OFF \
    -DBUILD_opencv_calib3d=OFF \
    -DBUILD_opencv_dnn=OFF \
    -DBUILD_opencv_features2d=OFF \
    -DBUILD_opencv_flann=OFF \
    -DBUILD_opencv_highgui=OFF \
    -DBUILD_opencv_imgcodecs=OFF \
    -DBUILD_opencv_ml=OFF \
    -DBUILD_opencv_objdetect=OFF \
    -DBUILD_opencv_photo=OFF \
    -DBUILD_opencv_video=OFF \
    -DBUILD_opencv_videoio=OFF \
    -DBUILD_opencv_stitching=OFF \
    "$OPENCV_SOURCE"
  
  echo "Building $ABI..."
  ninja -j$(nproc)
  
  echo "✓ Build complete for $ABI"
  
  # Restore original CMakeLists.txt
  if [ -f "$JAVA_CMAKE.bak" ]; then
    mv "$JAVA_CMAKE.bak" "$JAVA_CMAKE"
  fi
done

echo ""
echo "============================================"
echo "Copying libraries to Tiny-OpenCV project..."
echo "============================================"

PROJECT_JNI_DIR="$PROJECT_DIR/opencv/src/main/jniLibs"

for ABI in "${ABIS[@]}"; do
  echo "Copying $ABI libraries..."
  
  ABI_BUILD_DIR="$OUTPUT_DIR/$ABI"
  DEST_DIR="$PROJECT_JNI_DIR/$ABI"
  
  mkdir -p "$DEST_DIR"
  
  # Find and copy libopencv_java4.so
  JAVA_LIB=$(find "$ABI_BUILD_DIR" -name "libopencv_java4.so" | head -1)
  
  if [ -z "$JAVA_LIB" ]; then
    echo "ERROR: libopencv_java4.so not found for $ABI"
    exit 1
  fi
  
  cp "$JAVA_LIB" "$DEST_DIR/"
  
  # Copy libc++_shared.so from NDK
  NDK_LIBCXX="$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib"
  
  case $ABI in
    arm64-v8a)
      cp "$NDK_LIBCXX/aarch64-linux-android/libc++_shared.so" "$DEST_DIR/"
      ;;
    armeabi-v7a)
      cp "$NDK_LIBCXX/arm-linux-androideabi/libc++_shared.so" "$DEST_DIR/"
      ;;
    x86)
      cp "$NDK_LIBCXX/i686-linux-android/libc++_shared.so" "$DEST_DIR/"
      ;;
    x86_64)
      cp "$NDK_LIBCXX/x86_64-linux-android/libc++_shared.so" "$DEST_DIR/"
      ;;
  esac
  
  echo "✓ Copied $ABI"
done

echo ""
echo "============================================"
echo "Verifying 16KB page alignment..."
echo "============================================"

for ABI in "${ABIS[@]}"; do
  LIB="$PROJECT_JNI_DIR/$ABI/libopencv_java4.so"
  echo -n "$ABI: "
  ALIGNMENT=$(readelf -l "$LIB" | grep -A1 "LOAD" | grep "Align" | head -1 | awk '{print $NF}')
  if [ "$ALIGNMENT" = "0x4000" ]; then
    echo "✓ 16KB aligned"
  else
    echo "✗ Not aligned (found: $ALIGNMENT)"
  fi
done

echo ""
echo "============================================"
echo "Library size comparison:"
echo "============================================"

for ABI in "${ABIS[@]}"; do
  LIB="$PROJECT_JNI_DIR/$ABI/libopencv_java4.so"
  SIZE=$(ls -lh "$LIB" | awk '{print $5}')
  echo "$ABI: $SIZE"
done

echo ""
TOTAL_SIZE=$(du -sh "$PROJECT_JNI_DIR" | awk '{print $1}')
echo "Total jniLibs size: $TOTAL_SIZE"

echo ""
echo "============================================"
echo "✓ Tiny OpenCV build complete!"
echo "============================================"
echo ""
echo "Expected size reduction:"
echo "  Old tiny build:  ~5.6 MB (core + imgproc only)"
echo "  Previous build: ~23 MB (12 modules)"
echo "  New build:      Should be ~5-6 MB (core + imgproc only)"
echo ""
