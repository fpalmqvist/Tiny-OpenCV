# Publishing Guide for OpenCV440 AAR

## Quick Summary

✅ **Release AAR Built**: `openCV440-release.aar` (21 MB)  
✅ **16KB Page Size Compliant**  
✅ **Ready for Distribution**

## Distribution Methods

### Method 1: Direct AAR Distribution (Simplest)

Just share the AAR file:
```
openCV440/build/outputs/aar/openCV440-release.aar
```

Users can integrate it:
```gradle
dependencies {
    implementation files('libs/openCV440-release.aar')
}
```

---

### Method 2: Publish to Maven Local (For Local Development)

Add this to `openCV440/build.gradle` (after line 2):

```gradle
apply plugin: 'maven-publish'

publishing {
    publications {
        release(MavenPublication) {
            groupId = 'com.zynkware'
            artifactId = 'opencv440'
            version = '4.4.0'
            
            afterEvaluate {
                from components.release
            }
        }
    }
}
```

Then publish:
```bash
.\gradlew :openCV440:publishToMavenLocal
```

Users can then use it:
```gradle
repositories {
    mavenLocal()
}

dependencies {
    implementation 'com.zynkware:opencv440:4.4.0'
}
```

---

### Method 3: JitPack.io (GitHub-based, Free)

**Steps:**
1. Push your code to GitHub
2. Create a release tag:
   ```bash
   git tag v4.4.0
   git push origin v4.4.0
   ```
3. Visit https://jitpack.io and enter your repo
4. JitPack will build and host your AAR automatically

**Note**: You may need to uncomment the maven-publish plugin in `openCV440/build.gradle`

Users integrate via:
```gradle
repositories {
    maven { url 'https://jitpack.io' }
}

dependencies {
    implementation 'com.github.YourUsername:Tiny-OpenCV:v4.4.0'
}
```

---

### Method 4: Maven Central (Official Distribution)

**Requirements:**
- Sonatype OSSRH account
- GPG signing key
- Domain verification

**Setup** in `openCV440/build.gradle`:

```gradle
apply plugin: 'maven-publish'
apply plugin: 'signing'

publishing {
    publications {
        release(MavenPublication) {
            groupId = 'com.zynkware'
            artifactId = 'opencv440'
            version = '4.4.0'
            
            afterEvaluate {
                from components.release
            }
            
            pom {
                name = 'OpenCV 4.4.0 for Android'
                description = 'OpenCV 4.4.0 Android library with 16KB page size support'
                url = 'https://github.com/YourUsername/Tiny-OpenCV'
                
                licenses {
                    license {
                        name = 'Apache License 2.0'
                        url = 'https://www.apache.org/licenses/LICENSE-2.0'
                    }
                }
                
                developers {
                    developer {
                        id = 'yourId'
                        name = 'Your Name'
                        email = 'your@email.com'
                    }
                }
                
                scm {
                    connection = 'scm:git:git://github.com/YourUsername/Tiny-OpenCV.git'
                    developerConnection = 'scm:git:ssh://github.com/YourUsername/Tiny-OpenCV.git'
                    url = 'https://github.com/YourUsername/Tiny-OpenCV'
                }
            }
        }
    }
    
    repositories {
        maven {
            name = "OSSRH"
            url = uri("https://s01.oss.sonatype.org/service/local/staging/deploy/maven2/")
            credentials {
                username = project.findProperty("ossrhUsername") ?: ""
                password = project.findProperty("ossrhPassword") ?: ""
            }
        }
    }
}

signing {
    sign publishing.publications.release
}
```

Then publish:
```bash
.\gradlew :openCV440:publishReleasePublicationToOSSRHRepository
```

---

### Method 5: Private Maven Repository

If you have a private Maven repository (e.g., Nexus, Artifactory):

```gradle
apply plugin: 'maven-publish'

publishing {
    publications {
        release(MavenPublication) {
            groupId = 'com.zynkware'
            artifactId = 'opencv440'
            version = '4.4.0'
            
            afterEvaluate {
                from components.release
            }
        }
    }
    
    repositories {
        maven {
            name = "PrivateRepo"
            url = uri("https://your-repo.com/maven/")
            credentials {
                username = project.findProperty("repoUsername") ?: ""
                password = project.findProperty("repoPassword") ?: ""
            }
        }
    }
}
```

Store credentials in `~/.gradle/gradle.properties`:
```properties
repoUsername=your_username
repoPassword=your_password
```

---

## Verification After Publishing

### Check Maven Local
```bash
ls ~/.m2/repository/com/zynkware/opencv440/4.4.0/
```

Should contain:
- `opencv440-4.4.0.aar`
- `opencv440-4.4.0.pom`
- Checksums (.md5, .sha1, .sha256, .sha512)

### Test Integration
Create a new Android project and add the dependency to verify it works.

---

## Current Files

### Available Now
- ✅ `openCV440-release.aar` - Release AAR (21 MB)
- ✅ `openCV440-debug.aar` - Debug AAR (21 MB)
- ✅ SHA-256 checksum documented

### Generated During Publishing (Maven)
When you publish to Maven, these files are automatically created:
- `.aar` - The library
- `.pom` - Maven metadata
- `-sources.jar` - Source code (if configured)
- `-javadoc.jar` - Documentation (if configured)
- Checksums for verification

---

## Recommended Approach

**For Open Source Projects**: JitPack.io (Method 3)
- ✅ Free
- ✅ Automatic building
- ✅ Easy to use
- ✅ GitHub integration

**For Private/Commercial**: Private Maven (Method 5)
- ✅ Full control
- ✅ Secure
- ✅ Integration with CI/CD

**For Quick Testing**: Maven Local (Method 2)
- ✅ Fast
- ✅ Local only
- ✅ No setup needed

**For Wide Distribution**: Maven Central (Method 4)
- ✅ Official
- ✅ Trusted
- ✅ Best for libraries
- ⚠️ Complex setup

---

## Questions?

- **Where is the AAR?** → `openCV440/build/outputs/aar/openCV440-release.aar`
- **How big is it?** → 21 MB (uncompressed for 16KB compliance)
- **Can I use it now?** → Yes! Copy to your project's `libs/` folder
- **Is it signed?** → AAR files don't need signing (only APKs do)

---

**The AAR is ready to use! Choose the distribution method that fits your needs.**

