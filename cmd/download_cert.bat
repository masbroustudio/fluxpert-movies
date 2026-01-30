@echo off
echo ==========================================
echo  Download TMDB LEAF Certificate
echo ==========================================
echo.

REM Check if OpenSSL is available
where openssl >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: OpenSSL not found!
    echo.
    echo MANUAL DOWNLOAD INSTRUCTIONS:
    echo ================================
    echo.
    echo 1. Open Chrome/Edge and go to: https://api.themoviedb.org
    echo.
    echo 2. Click PADLOCK icon in address bar
    echo    - Select "Connection is secure"
    echo    - Click "Certificate is valid"
    echo.
    echo 3. In Certificate window:
    echo    - Select the FIRST certificate in the list
    echo      ^(Should show: CN=*.themoviedb.org^)
    echo    - Click "Details" tab
    echo    - Click "Export..." button
    echo.
    echo 4. Save Certificate:
    echo    - Filename: certificates.pem
    echo    - Format: "Base-64 encoded X.509 (.CER)" or "PEM"
    echo    - DO NOT choose DER format!
    echo.
    echo 5. Copy file to:
    echo    D:\Dicoding\Fluxpert01\assets\certificates\certificates.pem
    echo.
    echo IMPORTANT: Make sure the certificate shows:
    echo    Subject: CN=*.themoviedb.org
    echo    NOT: CN=Amazon Root CA 1
    echo.
    pause
    exit /b 1
)

echo Creating certificates directory...
if not exist "assets\certificates" mkdir assets\certificates

echo.
echo Downloading LEAF certificate from api.themoviedb.org...
echo This will get the SERVER certificate, not the root CA
echo.

REM Download full certificate chain, extract only the FIRST certificate (leaf)
echo. | openssl s_client -servername api.themoviedb.org -connect api.themoviedb.org:443 -showcerts 2>nul > temp_certs.txt

REM Extract first certificate only
powershell -Command "$content = Get-Content temp_certs.txt -Raw; if ($content -match '(?s)(-----BEGIN CERTIFICATE-----.*?-----END CERTIFICATE-----)') { $matches[1] | Out-File -Encoding ASCII assets\certificates\certificates.pem }"

del temp_certs.txt 2>nul

if exist "assets\certificates\certificates.pem" (
    echo.
    echo ✓ Certificate downloaded successfully!
    echo   Location: assets\certificates\certificates.pem
    echo.
    echo Certificate Information:
    echo ----------------------------------------
    openssl x509 -in assets\certificates\certificates.pem -noout -subject -issuer -dates
    echo ----------------------------------------
    echo.
    
    REM Verify it's the correct certificate
    openssl x509 -in assets\certificates\certificates.pem -noout -subject | findstr /C:"themoviedb.org" >nul
    if %ERRORLEVEL% EQU 0 (
        echo ✓ Correct certificate! ^(*.themoviedb.org^)
    ) else (
        echo ✗ WARNING: This might be wrong certificate!
        echo   Expected: CN=*.themoviedb.org
        openssl x509 -in assets\certificates\certificates.pem -noout -subject
        echo.
        echo   If you see "Amazon Root CA", you downloaded the wrong cert!
        echo   Please download the FIRST/LEAF certificate, not the root.
    )
) else (
    echo.
    echo ✗ Failed to download certificate!
    echo   Please use manual download instructions above.
)

echo.
pause


