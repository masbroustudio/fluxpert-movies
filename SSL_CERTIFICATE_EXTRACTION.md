# SSL Certificate Extraction Guide for TMDB

## Method 1: Via Chrome/Edge Browser (EASIEST)

### Steps:
1. Open browser (Chrome/Edge)
2. Navigate to: https://api.themoviedb.org
3. Click the **🔒 Lock icon** in address bar
4. Click **"Connection is secure"**
5. Click **"Certificate is valid"**
6. Go to **"Details"** tab
7. Click **"Export..."** button
8. Save as: `tmdb.cer` (DER format)
9. Move file to: `D:\Dicoding\Fluxpert01\assets\certificates\tmdb.cer`

## Method 2: Via OpenSSL Command

```bash
# Extract certificate using OpenSSL
openssl s_client -servername api.themoviedb.org -connect api.themoviedb.org:443 < /dev/null | openssl x509 -outform DER -out tmdb.cer

# Move to project
move tmdb.cer D:\Dicoding\Fluxpert01\assets\certificates\
```

## Method 3: Via Firefox

1. Open Firefox
2. Navigate to: https://api.themoviedb.org
3. Click **🔒 Lock icon** → "Connection secure" → "More information"
4. Click **"View Certificate"** button
5. Scroll down to **"Miscellaneous"** section
6. Click **"Download"** → Select **"DER"** format
7. Save as `tmdb.cer`
8. Move to: `D:\Dicoding\Fluxpert01\assets\certificates\`

## Verification

After extracting, the certificate should be:
- **Location**: `assets/certificates/tmdb.cer`
- **Format**: DER (binary format)
- **Size**: ~1-2 KB typically

## Expected Certificate Info

- **Issued to**: *.themoviedb.org
- **Issued by**: Let's Encrypt or DigiCert (or similar CA)
- **Valid until**: Check expiration date (usually 90 days for Let's Encrypt)

## Next Steps

After you have the certificate:
1. Create `assets/certificates/` folder
2. Place `tmdb.cer` file there
3. Notify me to continue with implementation
