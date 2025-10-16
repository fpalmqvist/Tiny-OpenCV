# Changelog

All notable changes to this OpenCV Android library will be documented in this file.

## [4.4.2] - 2025-10-15

### 🎯 Major Changes
- **16KB Page Size Compliance**: All native libraries rebuilt with 16KB page alignment
- **Android 15 Support**: Full compatibility with Android 15 (API 35) devices
- **Google Play Ready**: Meets all requirements for apps targeting API 35+

### ✨ Added
- 16KB page alignment on all `.so` files (`-Wl,-z,max-page-size=16384`)
- `ANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES` CMake flag
- Support for devices with 16KB memory pages
- Build verification with `readelf` for all ABIs

### 🔧 Changed
- **Target SDK**: Updated to API 35 (Android 15)
- **Compile SDK**: Updated to API 35
- **Build Tools**: Updated to 35.0.0
- **NDK**: Built with android-ndk-r27 (latest)
- **AGP**: Updated to 8.7.0
- **Gradle**: Updated to 8.10.2
- **Kotlin**: Updated to 2.0.20
- **CMake**: Using 3.28.3
- **Version Code**: Bumped to 5

### 🏗️ Build Configuration
- Built with `BUILD_FAT_JAVA_LIB=ON` for single library architecture
- Applied 16KB linker flags to all native builds
- Optimized packaging with `useLegacyPackaging = false`
- Updated all Gradle dependencies to latest versions

### 📦 Library Sizes
| ABI           | libopencv_java4.so | libc++_shared.so | Total   |
|---------------|-------------------|------------------|---------|
| arm64-v8a     | 23 MB             | 1.8 MB           | 24.8 MB |
| armeabi-v7a   | 15 MB             | 1.3 MB           | 16.3 MB |
| x86           | 42 MB             | 1.7 MB           | 43.7 MB |
| x86_64        | 57 MB             | 1.8 MB           | 58.8 MB |

**Total AAR Size**: 60.6 MB

### ✅ Verified
- [x] All ABIs built successfully
- [x] 16KB page alignment confirmed with `readelf`
- [x] Debug build passes
- [x] Release build passes
- [x] AAR generated successfully
- [x] Libraries properly packaged in AAR

### 🔍 Technical Verification
```bash
# Alignment verification for all ABIs
readelf -l libopencv_java4.so | grep LOAD
# Result: All segments show 0x4000 (16KB) alignment ✅
```

### 📝 Migration Notes
If upgrading from 4.4.1 or earlier:

1. **Update your app's manifest**:
   ```xml
   <property
       android:name="android.app.enforce16KbPageSize"
       android:value="true" />
   ```

2. **Update target SDK** (if not already done):
   ```groovy
   android {
       targetSdk 35
   }
   ```

3. **Clean and rebuild**:
   ```bash
   ./gradlew clean
   ./gradlew build
   ```

### 🐛 Known Issues
- None reported

### 🔗 References
- [Android 16KB Page Size Guide](https://developer.android.com/guide/practices/page-sizes)
- [Google Play API 35 Requirements](https://support.google.com/googleplay/android-developer/answer/11926878)

---

## [4.4.1] - 2020-XX-XX

### Changed
- Updated from OpenCV 4.4.0 base
- Minor version bump
- Legacy 4KB page alignment (not compatible with some Android 15 devices)

---

## [4.4.0] - 2020-XX-XX

### Initial Release
- OpenCV 4.4.0 for Android
- Support for arm64-v8a, armeabi-v7a, x86, x86_64
- Built with older NDK and build tools
- 4KB page alignment (default at the time)

---

**Note**: Versions prior to 4.4.2 are not recommended for apps targeting Android API 35+ due to 16KB page size requirements.

