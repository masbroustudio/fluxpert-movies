@echo off
echo ========================================
echo Creating GitHub Actions Workflow Folder
echo ========================================
echo.

cd /d "%~dp0"

echo Creating .github/workflows folder...
mkdir ".github" 2>nul
mkdir ".github\workflows" 2>nul
echo ✓ Folders created

echo.
echo ========================================
echo ✅ Ready for CI/CD setup!
echo ========================================
echo.
pause
