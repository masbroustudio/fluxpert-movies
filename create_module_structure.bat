@echo off
echo ========================================
echo Creating Modular Folder Structure...
echo ========================================

cd /d "%~dp0lib"

echo.
echo [1/3] Creating CORE module folders...
mkdir core 2>nul
mkdir core\common 2>nul
mkdir core\network 2>nul
mkdir core\database 2>nul
mkdir core\di 2>nul
echo ✓ Core module folders created

echo.
echo [2/3] Creating MOVIE module folders...
mkdir movie 2>nul
mkdir movie\data 2>nul
mkdir movie\data\models 2>nul
mkdir movie\data\datasources 2>nul
mkdir movie\data\repositories 2>nul
mkdir movie\domain 2>nul
mkdir movie\domain\entities 2>nul
mkdir movie\domain\repositories 2>nul
mkdir movie\domain\usecases 2>nul
mkdir movie\presentation 2>nul
mkdir movie\presentation\pages 2>nul
mkdir movie\presentation\provider 2>nul
mkdir movie\presentation\widgets 2>nul
echo ✓ Movie module folders created

echo.
echo [3/3] Creating TV_SERIES module folders...
mkdir tv_series 2>nul
mkdir tv_series\data 2>nul
mkdir tv_series\data\models 2>nul
mkdir tv_series\data\datasources 2>nul
mkdir tv_series\data\repositories 2>nul
mkdir tv_series\domain 2>nul
mkdir tv_series\domain\entities 2>nul
mkdir tv_series\domain\repositories 2>nul
mkdir tv_series\domain\usecases 2>nul
mkdir tv_series\presentation 2>nul
mkdir tv_series\presentation\pages 2>nul
mkdir tv_series\presentation\bloc 2>nul
mkdir tv_series\presentation\widgets 2>nul
echo ✓ TV Series module folders created

echo.
echo ========================================
echo ✅ ALL FOLDERS CREATED SUCCESSFULLY!
echo ========================================
echo.
echo Next step: Run 'create_test_structure.bat' to create test folders
echo Or notify me to start moving files!
echo.
pause
