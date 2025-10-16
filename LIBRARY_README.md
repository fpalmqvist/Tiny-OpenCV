# OpenCV 4.4.2 for Android (16KB Page Size Compliant)

[![Version](https://img.shields.io/badge/version-4.4.2-blue.svg)](https://github.com/opencv/opencv)
[![Android](https://img.shields.io/badge/Android-API%2021+-green.svg)](https://developer.android.com)
[![Page Size](https://img.shields.io/badge/Page%20Size-16KB%20Ready-brightgreen.svg)](https://developer.android.com/guide/practices/page-sizes)

## 🎯 What's Special About This Build?

This is a **16KB page size compliant** build of OpenCV 4.4.0 for Android, updated to version **4.4.2**.

### Why This Matters:
- ✅ **Android 15 Compatible**: Works on devices with 16KB memory pages
- ✅ **Google Play Ready**: Meets requirements for apps targeting API 35+
- ✅ **No Crashes**: Won't crash on 16KB page size devices
- ✅ **Latest Build Tools**: Built with NDK r27, AGP 8.7.0, Gradle 8.10.2

## 📦 What's Included

### AAR Contents
- **File**: `opencv-release.aar` (60.6 MB)
- **Version**: 4.4.2
- **Package**: `org.opencv`
- **Group**: `com.zynkware`

### Supported ABIs
All libraries built with **16KB page alignment** (`-Wl,-z,max-page-size=16384`):

- ✅ `arm64-v8a` - 64-bit ARM (23 MB + 1.8 MB libc++)
- ✅ `armeabi-v7a` - 32-bit ARM (15 MB + 1.3 MB libc++)
- ✅ `x86` - Intel 32-bit (42 MB + 1.7 MB libc++)
- ✅ `x86_64` - Intel 64-bit (57 MB + 1.8 MB libc++)

### Build Configuration
- **Min SDK**: API 21 (Android 5.0)
- **Target SDK**: API 35 (Android 15)
- **Compile SDK**: API 35
- **STL**: `c++_shared` (included for all ABIs)
- **Page Alignment**: 16KB (0x4000)

## 🚀 Usage

### Gradle (Kotlin DSL)
```kotlin
dependencies {
    implementation("com.zynkware:opencv:4.4.2")
}
```

### Gradle (Groovy)
```groovy
dependencies {
    implementation 'com.zynkware:opencv:4.4.2'
}
```

### Local AAR
```groovy
dependencies {
    implementation(files('libs/opencv-release.aar'))
}
```

## ✅ Verification

### Check Page Alignment
```bash
# Extract AAR
unzip opencv-release.aar

# Check alignment (should show 0x4000 = 16KB)
readelf -l jni/arm64-v8a/libopencv_java4.so | grep LOAD

# Expected output:
#   LOAD  ... R E 0x4000
#   LOAD  ... RW  0x4000
```

### Verify in Your App
```kotlin
// In your Activity/Fragment
if (OpenCVLoader.initDebug()) {
    Log.d("OpenCV", "OpenCV loaded successfully!")
    Log.d("OpenCV", "Version: ${Core.VERSION}")
} else {
    Log.e("OpenCV", "OpenCV initialization failed!")
}
```

## 📋 Technical Details

### Build Environment
- **NDK**: android-ndk-r27
- **CMake**: 3.28.3
- **Build System**: Ninja
- **Compiler**: Clang 18.0.1
- **Host**: WSL2 Ubuntu on Windows 11

### Linker Flags Applied
```cmake
CMAKE_SHARED_LINKER_FLAGS = "-Wl,-z,max-page-size=16384"
CMAKE_EXE_LINKER_FLAGS = "-Wl,-z,max-page-size=16384"
```

### CMake Configuration
```cmake
-DBUILD_FAT_JAVA_LIB=ON
-DBUILD_opencv_java=ON
-DBUILD_ANDROID_PROJECTS=OFF
-DANDROID_STL=c++_shared
-DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON
```

### Manifest Configuration
Your app should include:
```xml
<application>
    <property
        android:name="android.app.enforce16KbPageSize"
        android:value="true" />
</application>
```

## 🔍 What Changed from 4.4.0 to 4.4.2?

### Version 4.4.2 (This Build)
- ✅ **16KB page alignment** on all native libraries
- ✅ Built with latest NDK r27
- ✅ Target SDK updated to API 35
- ✅ CMake configuration optimized for Android 15

### Original 4.4.0
- ❌ 4KB page alignment (incompatible with some Android 15 devices)
- ⚠️ Older NDK and build tools
- ⚠️ Target SDK 34 or lower

## 📱 Android 15 / API 35 Requirements

Apps targeting API 35 must support 16KB page sizes:
- **Play Store Requirement**: Mandatory for new apps (August 2024+)
- **Device Support**: Pixel 9 Pro and other high-end devices
- **Crash Prevention**: Apps with 4KB libraries may crash on 16KB devices

### How This Build Helps:
1. **Native Libraries**: All `.so` files built with 16KB alignment
2. **Packaging**: Proper `useLegacyPackaging = false` configuration
3. **Manifest**: Ready for 16KB enforcement property
4. **Testing**: Pre-verified with `readelf` on all ABIs

## 🛠️ Building From Source

If you need to rebuild or customize:

```bash
# The successful build script is included
./build_opencv_java_patched.sh

# This script:
# 1. Patches OpenCV to skip android_sdk
# 2. Builds with BUILD_FAT_JAVA_LIB=ON
# 3. Applies 16KB linker flags
# 4. Copies libraries to project
```

See `opencv_java_patched.log` for the complete build log.

## 📦 Output Files

### AAR Location
```
opencv/build/outputs/aar/opencv-release.aar
```

### Source Libraries
```
opencv/src/main/jniLibs/
├── arm64-v8a/
│   ├── libopencv_java4.so (23 MB)
│   └── libc++_shared.so (1.8 MB)
├── armeabi-v7a/
│   ├── libopencv_java4.so (15 MB)
│   └── libc++_shared.so (1.3 MB)
├── x86/
│   ├── libopencv_java4.so (42 MB)
│   └── libc++_shared.so (1.7 MB)
└── x86_64/
    ├── libopencv_java4.so (57 MB)
    └── libc++_shared.so (1.8 MB)
```

## 🎓 More Information

- [Android 16KB Page Size Guide](https://developer.android.com/guide/practices/page-sizes)
- [OpenCV Android Documentation](https://docs.opencv.org/4.4.0/d5/df8/tutorial_dev_with_OCV_on_Android.html)
- [Google Play API Requirements](https://support.google.com/googleplay/android-developer/answer/11926878)

## 📄 License

OpenCV is released under the **Apache 2.0 License**.

This specific build maintains the same license and adds:
- 16KB page size compliance
- Updated build configuration
- Android 15 compatibility

---

**Built**: October 15, 2025  
**Version**: 4.4.2 (16KB compliant)  
**Status**: ✅ Production Ready  
**Compliance**: ✅ Google Play API 35+ Requirements Met

