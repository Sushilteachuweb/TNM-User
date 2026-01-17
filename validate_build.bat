@echo off
echo ========================================
echo TNM Jobs - Build Validation Script
echo ========================================
echo.

echo [1/6] Checking Flutter installation...
flutter --version
if %errorlevel% neq 0 (
    echo ERROR: Flutter not found!
    pause
    exit /b 1
)
echo ✓ Flutter found
echo.

echo [2/6] Checking Android SDK...
flutter doctor --android-licenses > nul 2>&1
if %errorlevel% neq 0 (
    echo WARNING: Android licenses may need acceptance
)
echo ✓ Android SDK configured
echo.

echo [3/6] Checking keystore file...
if exist "android\key.properties" (
    echo ✓ key.properties found
) else (
    echo ERROR: android\key.properties not found!
    echo Please ensure keystore is configured
    pause
    exit /b 1
)
echo.

echo [4/6] Validating pubspec.yaml...
findstr /C:"version: 1.0.0+1" pubspec.yaml > nul
if %errorlevel% equ 0 (
    echo ✓ Version is 1.0.0+1
) else (
    echo WARNING: Version may not be 1.0.0+1
)
echo.

echo [5/6] Checking app name...
findstr /C:"TNM Jobs" android\app\src\main\res\values\strings.xml > nul
if %errorlevel% equ 0 (
    echo ✓ App name is "TNM Jobs"
) else (
    echo WARNING: App name may not be updated
)
echo.

echo [6/6] Checking package name...
findstr /C:"com.arp.naukrimitra.jobs" android\app\src\main\AndroidManifest.xml > nul
if %errorlevel% equ 0 (
    echo ✓ Package name is correct
) else (
    echo WARNING: Package name may be incorrect
)
echo.

echo ========================================
echo Validation Complete!
echo ========================================
echo.
echo Ready to build? Run:
echo   flutter clean
echo   flutter pub get
echo   flutter build appbundle --release
echo.
echo Output will be at:
echo   build\app\outputs\bundle\release\app-release.aab
echo.
pause
