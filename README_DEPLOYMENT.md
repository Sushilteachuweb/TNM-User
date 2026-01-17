# TNM Jobs - Play Store Deployment Guide

## 🎯 Quick Start

Your app is **ready for Play Store submission**. All configurations have been updated and verified.

### Build Release Now
```bash
flutter clean && flutter pub get && flutter build appbundle --release
```

**Output**: `build/app/outputs/bundle/release/app-release.aab`

---

## ✅ What Was Updated

### 1. App Name
- **Changed from**: "Naukri Mitra Jobs"
- **Changed to**: "TNM Jobs"
- **File**: `android/app/src/main/res/values/strings.xml`

### 2. Version Information
- **Reset to**: 1.0.0+1 (for new app submission)
- **File**: `pubspec.yaml`

### 3. Permissions (Play Store Compliant)
- ✅ **Kept**: INTERNET, CAMERA (optional)
- ❌ **Removed**: All storage, location, and audio permissions
- **Result**: Minimal permissions for maximum compliance

### 4. Image/File Picker (Verified Compliant)
- ✅ Uses `image_picker` package (no direct permissions)
- ✅ Uses `file_picker` package (no direct permissions)
- ✅ No `permission_handler` package
- ✅ No direct permission request code
- **Files verified**:
  - `lib/Screens/profile/CreateProfile.dart`
  - `lib/Screens/profile/UpdateProfileScreen.dart`
  - `lib/Screens/custom/resume_service.dart`

### 5. Build Configuration
- ✅ Keystore configured
- ✅ Signing enabled for release builds
- ✅ Target SDK 36 (Android 14)
- ✅ R8 shrinking enabled

---

## 📚 Documentation Created

| File | Purpose |
|------|---------|
| **DEPLOYMENT_SUMMARY.md** | Complete overview of all changes |
| **PLAY_STORE_DEPLOYMENT_CHECKLIST.md** | Comprehensive deployment guide |
| **BUILD_RELEASE_GUIDE.md** | Quick build commands and procedures |
| **FINAL_CHECKLIST.md** | Pre-submission checklist |
| **validate_build.bat** | Automated validation script |
| **README_DEPLOYMENT.md** | This file - quick reference |

---

## 🚀 Build & Deploy Steps

### Step 1: Validate Configuration
Run the validation script:
```bash
validate_build.bat
```

### Step 2: Build Release
```bash
flutter clean
flutter pub get
flutter build appbundle --release
```

### Step 3: Test on Device
```bash
# Build test APK
flutter build apk --release --split-per-abi

# Install on device
flutter install
```

### Step 4: Verify Functionality
- [ ] App name shows "TNM Jobs"
- [ ] Login/OTP works
- [ ] Profile creation with photo works
- [ ] Profile editing with photo works
- [ ] Resume upload works
- [ ] No permission errors
- [ ] No crashes

### Step 5: Upload to Play Store
1. Go to [Play Console](https://play.google.com/console)
2. Create new app or select existing
3. Upload `app-release.aab`
4. Complete store listing
5. Submit for review

---

## ⚠️ Important Notes

### Security
- ✅ Keystore file is in `.gitignore`
- ✅ `key.properties` is in `.gitignore`
- ⚠️ **NEVER commit keystore or passwords**
- ⚠️ **Backup keystore securely - if lost, cannot update app**

### Keystore Location
```
C:/Users/sushi/upload-keystore.jks
```

### Package Name
```
com.arp.naukrimitra.jobs
```

### Version Management
- **Current**: 1.0.0+1
- **Next update**: 1.0.1+2 (increment both)
- **Rule**: Version code must always increase

---

## 🔍 Verification Commands

### Check App Name
```bash
findstr "TNM Jobs" android\app\src\main\res\values\strings.xml
```

### Check Version
```bash
findstr "version: 1.0.0+1" pubspec.yaml
```

### Verify Signing
```bash
jarsigner -verify -verbose -certs build\app\outputs\bundle\release\app-release.aab
```

### Check Installed App
```bash
adb shell dumpsys package com.arp.naukrimitra.jobs | grep versionName
```

---

## 📱 Testing Checklist

### Critical Features
- [ ] App launches successfully
- [ ] Login/OTP verification
- [ ] Profile creation (with photo from camera/gallery)
- [ ] Profile editing (with photo update)
- [ ] Resume upload (PDF selection)
- [ ] Job browsing
- [ ] Job application
- [ ] Video playback
- [ ] Share functionality
- [ ] Language switching

### Performance
- [ ] App starts within 3 seconds
- [ ] Smooth scrolling
- [ ] No crashes
- [ ] No ANR errors
- [ ] Works on low-end devices

---

## 🎨 Play Store Requirements

### Required Assets
1. **Screenshots**: Minimum 2, recommended 8
2. **Feature Graphic**: 1024 x 500 px
3. **App Icon**: Already configured ✅
4. **Privacy Policy**: URL required
5. **Store Listing**: Short and full descriptions

### Suggested Short Description (80 chars max)
```
Find jobs easily. Apply instantly. Build your career with TNM Jobs.
```

### App Category
- **Primary**: Business
- **Tags**: jobs, career, employment, hiring

---

## 🐛 Troubleshooting

### Build Fails
**Error**: "Keystore not found"
**Fix**: Verify path in `android/key.properties`

**Error**: "Wrong password"
**Fix**: Check passwords in `android/key.properties`

**Error**: "Duplicate class"
**Fix**: Run `flutter clean` and rebuild

### App Crashes
**Issue**: Crashes on launch
**Fix**: 
1. Check logs: `adb logcat | grep Flutter`
2. Test on physical device
3. Rebuild with `flutter clean`

### Upload Rejected
**Issue**: "Missing privacy policy"
**Fix**: Add privacy policy URL in Play Console

**Issue**: "Insufficient screenshots"
**Fix**: Upload at least 2 screenshots

---

## 📞 Support Resources

- **Flutter Docs**: https://docs.flutter.dev/deployment/android
- **Play Console Help**: https://support.google.com/googleplay/android-developer
- **Flutter Community**: https://flutter.dev/community

---

## ✨ Success Criteria

Your app is ready when:
- ✅ Build completes without errors
- ✅ App installs successfully
- ✅ App name shows "TNM Jobs"
- ✅ All features work correctly
- ✅ No crashes or errors
- ✅ Image picker works without permission prompts
- ✅ File picker works for resume upload

---

## 🎉 Next Steps After Approval

1. Monitor crash reports in Play Console
2. Respond to user reviews promptly
3. Track user metrics and analytics
4. Plan incremental updates
5. Gather user feedback

---

**Status**: ✅ Ready for Build and Submission

**Last Updated**: January 16, 2026

**App Version**: 1.0.0 (Build 1)

**Package**: com.arp.naukrimitra.jobs

**App Name**: TNM Jobs

---

## 🚀 Ready to Build?

Run this command now:
```bash
flutter build appbundle --release
```

Then follow the steps in **FINAL_CHECKLIST.md** for submission.

**Good luck! 🎯**
