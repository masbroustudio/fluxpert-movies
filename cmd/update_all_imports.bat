@echo off
echo ========================================
echo MASS IMPORT PATH UPDATER
echo ========================================
echo.
echo This will update ALL import paths in:
echo - lib/ files (main code)
echo - test/ files (test code)
echo.
echo Press any key to continue or Ctrl+C to cancel...
pause >nul

cd /d "%~dp0"

echo.
echo [1/2] Updating lib/ files...
python update_imports.py
if errorlevel 1 (
    echo ❌ Error updating lib files!
    pause
    exit /b 1
)

echo.
echo [2/2] Updating test/ files...
python update_test_imports.py
if errorlevel 1 (
    echo ❌ Error updating test files!
    pause
    exit /b 1
)

echo.
echo ========================================
echo ✅ ALL IMPORTS UPDATED SUCCESSFULLY!
echo ========================================
echo.
echo Next steps:
echo 1. Run 'flutter analyze' to check for errors
echo 2. Run 'flutter test' to ensure tests pass
echo 3. Run 'flutter run' to test the app
echo.
pause
