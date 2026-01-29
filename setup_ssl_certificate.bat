@echo off
echo ========================================
echo SSL Certificate Setup for TMDB
echo ========================================
echo.

cd /d "%~dp0"

echo Creating assets/certificates folder...
mkdir "assets\certificates" 2>nul
echo ✓ Folder created: assets\certificates
echo.

echo ========================================
echo MANUAL ACTION REQUIRED
echo ========================================
echo.
echo Please extract TMDB SSL certificate manually:
echo.
echo METHOD 1: Via Browser (EASIEST)
echo --------------------------------
echo 1. Open Chrome/Edge
echo 2. Go to: https://api.themoviedb.org
echo 3. Click lock icon 🔒 → "Connection is secure"
echo 4. Click "Certificate is valid"
echo 5. Go to "Details" tab
echo 6. Click "Export..." button
echo 7. Save as: tmdb.cer (DER format)
echo 8. Move file to: %cd%\assets\certificates\tmdb.cer
echo.
echo METHOD 2: Via OpenSSL (if installed)
echo ------------------------------------
echo Run this command:
echo   openssl s_client -servername api.themoviedb.org -connect api.themoviedb.org:443 ^< nul ^| openssl x509 -outform DER -out tmdb.cer
echo   move tmdb.cer assets\certificates\
echo.
echo ========================================
echo After certificate is ready, notify AI to continue!
echo ========================================
echo.
pause
