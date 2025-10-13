# OpenCV 4.4.0 AAR - Release Notes

## Release Information

**Version**: 4.4.0  
**Build Date**: October 13, 2025  
**Package**: `com.zynkware:openCV440`  
**AAR File**: `openCV440-release.aar`

## Build Artifacts

### Main Release AAR
- **File**: `openCV440-release.aar`
- **Size**: 22,038,950 bytes (~21 MB)
- **SHA-256**: `8BEC891178D65627803415931C54EB54835F9E9A747FC8249E116023B0D1A7AF`
- **Location**: `openCV440/build/outputs/aar/`

### Debug AAR (for development)
- **File**: `openCV440-debug.aar`
- **Size**: 22,046,114 bytes (~21 MB)
- **Location**: `openCV440/build/outputs/aar/`

## AAR Contents

### Java Classes
- **classes.jar**: 97,851 bytes
- Complete OpenCV 4.4.0 Java API
  - `org.opencv.core.*` - Core functionality
  - `org.opencv.imgproc.*` - Image processing
  - `org.opencv.imgcodecs.*` - Image codecs
  - `org.opencv.android.*` - Android utilities

### Native Libraries (JNI)
All libraries include **16KB page size support** for Android 15+ compatibility.

#### arm64-v8a (64-bit ARM)
- `libopencv_java4.so` - 5.6 MB
- `libc++_shared.so` - 1.7 MB

#### armeabi-v7a (32-bit ARM)
- `libopencv_java4.so` - 3.1 MB
- `libc++_shared.so` - 1.3 MB

#### x86 (32-bit Intel/AMD)
- `libopencv_java4.so` - 16.7 MB
- `libc++_shared.so` - 1.6 MB

#### x86_64 (64-bit Intel/AMD)
- `libopencv_java4.so` - 25.1 MB
- `libc++_shared.so` - 1.6 MB

### Resources
- Android resources (values.xml)
- Manifest file

## Modern Android Compatibility

### API Level Support
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 35 (Android 15)
- **Compile SDK**: 35 (Android 15)

### 16KB Page Size Compliance ✅
This release is fully compliant with Google's 16KB page size requirements:
- Native libraries compiled with `-Wl,-z,max-page-size=16384`
- Flexible page size support enabled
- Optimized for next-generation Android devices

### Modern Build Tools
- **Gradle**: 8.10.2
- **Android Gradle Plugin**: 8.7.0
- **NDK**: 27.0.12077973
- **CMake**: 3.22.1
- **Java**: 17 compatibility

## Usage

### Gradle Dependency (from local AAR)
```gradle
dependencies {
    implementation files('path/to/openCV440-release.aar')
}
```

### Gradle Dependency (from Maven/JitPack)
```gradle
repositories {
    maven { url 'https://jitpack.io' }
}

dependencies {
    implementation 'com.zynkware:openCV440:4.4.0'
}
```

### Basic Usage
```kotlin
import org.opencv.core.Core
import org.opencv.core.Mat

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Load OpenCV native library
        System.loadLibrary("opencv_java4")
        
        // Use OpenCV
        val mat = Mat()
        // ... your OpenCV code
    }
}
```

## Key Features

### OpenCV 4.4.0 Modules Included
- ✅ Core functionality
- ✅ Image processing (imgproc)
- ✅ Image codecs (imgcodecs)
- ✅ Android utilities
- ✅ Java/Kotlin bindings

### Build Optimizations
- Release build with optimizations
- Stripped debug symbols (smaller size)
- ProGuard-ready (consumer rules included)
- Native libraries built with RelWithDebInfo (optimized + limited debug info)

### Platform Support
- ✅ ARM 64-bit (primary target for modern devices)
- ✅ ARM 32-bit (legacy device support)
- ✅ x86 64-bit (emulator support)
- ✅ x86 32-bit (emulator support)

## Testing

### Test App
A test application is included in the `app` module:
- Demonstrates OpenCV library integration
- Tests native library loading
- Available as debug/release APK for validation

### Lint Results
- ✅ All vital lint checks passed
- ✅ No critical issues
- ✅ Release ready

## Distribution Options

### Option 1: Local Maven Repository
Publish to local Maven for development:
```bash
.\gradlew :openCV440:publishToMavenLocal
```

### Option 2: JitPack
Push to GitHub and use JitPack.io for distribution:
1. Tag the release: `git tag v4.4.0`
2. Push: `git push origin v4.4.0`
3. JitPack will automatically build and host the AAR

### Option 3: Manual Distribution
Distribute the AAR file directly:
- Share `openCV440-release.aar` 
- Include in project libs folder
- Add to Gradle dependencies as shown above

### Option 4: Maven Central / Private Repository
Publish to Maven Central or private Maven repository using the maven-publish plugin.

## Verification

### File Integrity
Verify the AAR using the SHA-256 checksum:
```powershell
Get-FileHash openCV440-release.aar -Algorithm SHA256
```

Expected: `8BEC891178D65627803415931C54EB54835F9E9A747FC8249E116023B0D1A7AF`

### AAR Contents Validation
```bash
# Extract and inspect
unzip -l openCV440-release.aar

# Should contain:
# - classes.jar (Java API)
# - jni/arm64-v8a/*.so
# - jni/armeabi-v7a/*.so
# - jni/x86/*.so
# - jni/x86_64/*.so
# - AndroidManifest.xml
# - R.txt
# - res/ folder
```

## Migration from Previous Versions

### Breaking Changes
- **Namespace**: Now uses modern `namespace` declaration in build.gradle
- **Min SDK**: Increased from older versions (if applicable)
- **Target SDK**: Updated to Android 15 (API 35)

### Compatibility
- Backward compatible with OpenCV 4.4.0 API
- Native library loading remains the same
- No changes to OpenCV Java API

## Known Limitations

1. **APK Size**: Uncompressed libraries increase APK size (~21 MB contribution)
   - Trade-off for better performance and 16KB compliance
   - Libraries load directly from APK (no extraction needed)

2. **ProGuard**: Currently disabled in release build
   - Enable in `app/build.gradle` if needed for app module
   - Library module includes consumer ProGuard rules

## Changelog

### Version 4.4.0 (2025-10-13)
- ✅ Updated to Android Gradle Plugin 8.7.0
- ✅ Updated to Gradle 8.10.2
- ✅ Target SDK updated to 35 (Android 15)
- ✅ Added 16KB page size support
- ✅ Modern build configuration
- ✅ Java 17 compatibility
- ✅ NDK 27 support
- ✅ Removed deprecated configurations
- ✅ Optimized packaging

## Support & Documentation

### Official OpenCV Documentation
- [OpenCV 4.4.0 Documentation](https://docs.opencv.org/4.4.0/)
- [OpenCV Android Guide](https://docs.opencv.org/4.4.0/d9/df3/tutorial_android_dev_intro.html)

### Build System
- [Android Gradle Plugin 8.7 Release Notes](https://developer.android.com/build/releases/gradle-plugin)
- [16KB Page Size Guide](https://developer.android.com/guide/practices/page-sizes)

## License

This package follows OpenCV's original licensing terms. Please refer to the OpenCV project for specific license information.

---

**Built with ❤️ using modern Android tools**

