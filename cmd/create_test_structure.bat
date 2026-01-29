@echo off
echo ========================================
echo Creating Modular TEST Folder Structure...
echo ========================================

cd /d "%~dp0test"

echo.
echo [1/3] Creating CORE test folders...
mkdir core 2>nul
mkdir core\common 2>nul
mkdir core\network 2>nul
mkdir core\database 2>nul
echo ✓ Core test folders created

echo.
echo [2/3] Creating MOVIE test folders...
mkdir movie 2>nul
mkdir movie\data 2>nul
mkdir movie\data\models 2>nul
mkdir movie\data\datasources 2>nul
mkdir movie\data\repositories 2>nul
mkdir movie\domain 2>nul
mkdir movie\domain\usecases 2>nul
mkdir movie\presentation 2>nul
mkdir movie\presentation\provider 2>nul
mkdir movie\presentation\pages 2>nul
echo ✓ Movie test folders created

echo.
echo [3/3] Creating TV_SERIES test folders...
mkdir tv_series 2>nul
mkdir tv_series\data 2>nul
mkdir tv_series\data\models 2>nul
mkdir tv_series\data\datasources 2>nul
mkdir tv_series\data\repositories 2>nul
mkdir tv_series\domain 2>nul
mkdir tv_series\domain\usecases 2>nul
mkdir tv_series\presentation 2>nul
mkdir tv_series\presentation\bloc 2>nul
echo ✓ TV Series test folders created

echo.
echo ========================================
echo ✅ ALL TEST FOLDERS CREATED!
echo ========================================
echo.
echo Ready for file migration!
echo.
pause
