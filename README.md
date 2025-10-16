# OpenCV 4.4.2 for Android - 16KB Page Size Compliant

[![Version](https://img.shields.io/badge/version-4.4.2-blue.svg)](https://github.com/opencv/opencv)
[![Android](https://img.shields.io/badge/Android-API%2021+-green.svg)](https://developer.android.com)
[![Page Size](https://img.shields.io/badge/Page%20Size-16KB%20Ready-brightgreen.svg)](https://developer.android.com/guide/practices/page-sizes)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**Tiny-OpenCV 4.4.2 for Android** with full **16KB page size support** for Android 15+ devices. Only 31.6 MB with essential modules.

## 🎯 What Makes This Special?

This is a **16KB page size compliant** build of OpenCV 4.4.2 for Android with only essential modules (`core`, `imgproc`, `android`), ideal for apps targeting Android API 35+ that need minimal library size.

### Key Features

- ✅ **16KB Page Size Ready** - Works on all Android 15 devices
- ✅ **Google Play Compliant** - Meets API 35+ requirements  
- ✅ **Tiny Size** - Only 31.6 MB (minimal modules: core + imgproc)
- ✅ **All ABIs Supported** - arm64-v8a, armeabi-v7a, x86, x86_64
- ✅ **Latest Build Tools** - Built with NDK r27, AGP 8.7.0, Gradle 8.10.2
- ✅ **Crash Prevention** - Won't crash on 16KB page size devices

## 📦 Installation

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

## 🚀 Quick Start

### 1. Add to Manifest
```xml
<application>
    <!-- Enable 16KB page size support -->
    <property
        android:name="android.app.enforce16KbPageSize"
        android:value="true" />
</application>
```

### 2. Initialize OpenCV
```kotlin
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        if (OpenCVLoader.initDebug()) {
            Log.d("OpenCV", "OpenCV loaded successfully!")
            Log.d("OpenCV", "Version: ${Core.VERSION}")
        }
    }
}
```

## 📊 Library Sizes

**Total AAR**: 31.6 MB (**Tiny** build with only core + imgproc modules)

| ABI           | libopencv_java4.so | libc++_shared.so | Total   |
|---------------|-------------------|------------------|---------|
| arm64-v8a     | 6.4 MB            | 1.8 MB           | 8.2 MB  |
| armeabi-v7a   | 4.5 MB            | 1.3 MB           | 5.8 MB  |
| x86           | 23 MB             | 1.6 MB           | 24.6 MB |
| x86_64        | 38 MB             | 1.6 MB           | 39.6 MB |

*All libraries built with 16KB page alignment (verified with `readelf`)*

### Included Modules
- ✅ **core** - Basic operations
- ✅ **imgproc** - Image processing
- ✅ **android** - Android Utils (Mat ↔ Bitmap conversion)

## 🔧 Requirements

- **Min SDK**: API 21 (Android 5.0)
- **Target SDK**: API 35 (Android 15)
- **Gradle**: 8.0+
- **AGP**: 8.0+
- **Android Studio**: Arctic Fox or later

## ✅ Verification

All native libraries have been verified to have 16KB (0x4000) page alignment:

```bash
# Check alignment
readelf -l libopencv_java4.so | grep LOAD

# Expected output:
#   LOAD  ... R E 0x4000  ✅
#   LOAD  ... RW  0x4000  ✅
```

## 📚 Documentation

- **[LIBRARY_README.md](LIBRARY_README.md)** - Complete usage guide
- **[CHANGELOG.md](CHANGELOG.md)** - Version history
- **[PUBLICATION_READY.md](PUBLICATION_READY.md)** - Publication info
- **[BUILD_SUCCESS_SUMMARY.md](BUILD_SUCCESS_SUMMARY.md)** - Build details

## 🆚 Comparison with Original

### This Build (4.4.2)
- ✅ 16KB page alignment
- ✅ Android 15 compatible
- ✅ Google Play API 35 ready
- ✅ Built with NDK r27
- ✅ Target SDK 35

### Original (4.4.0)
- ❌ 4KB page alignment
- ⚠️ May crash on 16KB devices
- ⚠️ Not API 35 compliant
- ⚠️ Older build tools

## 📱 Android 15 / API 35 Support

Google Play requires apps targeting API 35+ to support 16KB page sizes:

- **Why?** Some Android 15 devices use 16KB memory pages
- **Impact:** Apps with 4KB-aligned libraries may crash
- **Solution:** This build! All libraries are 16KB-aligned

[Learn more about 16KB page sizes](https://developer.android.com/guide/practices/page-sizes)

## 🛠️ Building from Source

```bash
# Clone the repository
git clone https://github.com/your-repo/opencv-android.git

# Build the AAR
./gradlew :opencv:assembleRelease

# Output: opencv/build/outputs/aar/opencv-release.aar
```

See `build_opencv_java_patched.sh` for the complete build process.

## 📄 License

OpenCV is licensed under the **Apache 2.0 License**.

```
Copyright (C) 2000-2020, Intel Corporation, all rights reserved.
Copyright (C) 2009-2011, Willow Garage Inc., all rights reserved.
Copyright (C) 2009-2016, NVIDIA Corporation, all rights reserved.
```

This build adds 16KB page size compliance while maintaining the original license.

## 🙏 Credits

- **OpenCV Team** - Original OpenCV library
- **Google Android Team** - 16KB page size requirements and guidance
- Built with ❤️ for the Android community

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/your-repo/opencv-android/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-repo/opencv-android/discussions)
- **OpenCV Docs**: [opencv.org](https://docs.opencv.org/4.4.0/)

---

**Built**: October 15, 2025  
**Version**: 4.4.2  
**Status**: ✅ Production Ready  
**Compliance**: ✅ Google Play API 35 Requirements Met
