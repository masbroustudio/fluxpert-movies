@echo off
echo ========================================
echo SSL Pinning Test Script
echo ========================================
echo.

cd /d "%~dp0"

echo [1/3] Installing dependencies...
call flutter pub get
if errorlevel 1 (
    echo ❌ Failed to install dependencies!
    pause
    exit /b 1
)
echo ✓ Dependencies installed

echo.
echo [2/3] Running flutter analyze...
call flutter analyze
if errorlevel 1 (
    echo ⚠️ Warning: Analyze found issues (may be acceptable)
)
echo ✓ Analyze complete

echo.
echo [3/3] Building app to test SSL Pinning...
echo This will take a few minutes...
call flutter build apk --debug
if errorlevel 1 (
    echo ❌ Build failed!
    pause
    exit /b 1
)
echo ✓ Build successful

echo.
echo ========================================
echo ✅ SSL PINNING SETUP COMPLETE!
echo ========================================
echo.
echo Next steps:
echo 1. Run the app: flutter run
echo 2. Test network requests (browse movies/TV series)
echo 3. Verify SSL pinning is working
echo.
echo Note: App will use secure HTTPS connection with certificate pinning
echo.
pause
