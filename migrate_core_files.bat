@echo off
echo ========================================
echo PHASE 2: Moving CORE Module Files
echo ========================================
echo.

cd /d "%~dp0"

echo [1/3] Moving common utilities to core/common/...
move /Y "lib\common\utils.dart" "lib\core\common\utils.dart"
move /Y "lib\common\state_enum.dart" "lib\core\common\state_enum.dart"
move /Y "lib\common\failure.dart" "lib\core\common\failure.dart"
move /Y "lib\common\exception.dart" "lib\core\common\exception.dart"
move /Y "lib\common\constants.dart" "lib\core\common\constants.dart"
echo ✓ Common utilities moved

echo.
echo [2/3] Moving database helper to core/database/...
move /Y "lib\data\datasources\db\database_helper.dart" "lib\core\database\database_helper.dart"
echo ✓ Database helper moved

echo.
echo [3/3] Moving injection.dart to core/di/...
move /Y "lib\injection.dart" "lib\core\di\injection.dart"
echo ✓ Injection moved

echo.
echo [Cleanup] Removing empty folders...
rmdir "lib\common" 2>nul
rmdir "lib\data\datasources\db" 2>nul
echo ✓ Empty folders removed

echo.
echo ========================================
echo ✅ PHASE 2 COMPLETE!
echo ========================================
echo.
echo Next: Run 'migrate_movie_files.bat'
echo.
pause
