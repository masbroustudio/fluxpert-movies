@echo off
echo ========================================
echo CLEANUP: Moving Shared Files to Core
echo ========================================
echo.

cd /d "%~dp0"

echo [1/3] Moving genre entity to core...
move /Y "lib\domain\entities\genre.dart" "lib\core\common\genre.dart"
echo ✓ Genre entity moved

echo.
echo [2/3] Moving genre model to core...
move /Y "lib\data\models\genre_model.dart" "lib\core\common\genre_model.dart"
echo ✓ Genre model moved

echo.
echo [3/3] Moving about page to core...
move /Y "lib\presentation\pages\about_page.dart" "lib\core\common\about_page.dart"
echo ✓ About page moved

echo.
echo [Cleanup] Removing empty folders...
rmdir "lib\domain\entities" 2>nul
rmdir "lib\domain" 2>nul
rmdir "lib\data\models" 2>nul
rmdir "lib\data" 2>nul
rmdir "lib\presentation\pages" 2>nul
rmdir "lib\presentation" 2>nul
echo ✓ Empty folders removed

echo.
echo ========================================
echo ✅ CLEANUP COMPLETE!
echo ========================================
echo.
echo All files migrated successfully!
echo Notify me to update import paths...
echo.
pause
