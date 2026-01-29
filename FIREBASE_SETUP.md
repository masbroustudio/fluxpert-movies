# 🔥 Firebase Setup Guide - Fluxpert

Complete step-by-step guide untuk setup Firebase Crashlytics & Analytics di Fluxpert project.

---

## 📋 Prerequisites

- ✅ Flutter project sudah ada
- ✅ Android Studio atau VS Code installed
- ✅ Google account untuk Firebase Console
- ✅ Android device/emulator untuk testing

---

## 🚀 Phase 1: Firebase Console Setup (Manual)

### Step 1: Create Firebase Project

1. **Buka Firebase Console**
   - Go to: https://console.firebase.google.com
   - Login dengan Google account Anda

2. **Create New Project**
   - Click **"Add project"** atau **"Create a project"**
   - Project name: `Fluxpert` (atau nama sesuka Anda)
   - Click **Continue**

3. **Google Analytics**
   - Enable Google Analytics: **YES** (toggle ON)
   - Click **Continue**

4. **Configure Google Analytics**
   - Select **"Default Account for Firebase"** (atau create new)
   - Click **Create project**
   - Wait 1-2 minutes untuk Firebase setup

5. **Click "Continue"** setelah project ready

---

### Step 2: Add Android App to Firebase Project

1. **Add Android App**
   - Di Firebase Console, click **Android icon** (robot hijau)
   - Atau: Project Overview → Add app → Android

2. **Register App**
   - **Android package name**: `com.dicoding.ditonton`
     > ⚠️ PENTING: Harus sama persis dengan package name di `android/app/src/main/AndroidManifest.xml`
   
   - **App nickname (optional)**: `Fluxpert Android`
   - **Debug signing certificate (optional)**: Skip untuk sekarang
   - Click **Register app**

3. **Download config file**
   - Click **Download google-services.json**
   - Save file ke: `D:\Dicoding\Fluxpert01\android\app\google-services.json`
     > ⚠️ HARUS di folder `android/app/`, bukan `android/`!
   
   - Click **Next**

4. **Add Firebase SDK** (Skip di console)
   - Click **Next** (kita akan setup via code nanti)

5. **Run app to verify** (Skip)
   - Click **Continue to console**

---

### Step 3: Enable Crashlytics

1. **Di Firebase Console sidebar**, click **Crashlytics**

2. **Setup Crashlytics**
   - Click **"Enable Crashlytics"** atau **"Get started"**
   - Wait beberapa detik
   - Status akan berubah jadi **"Waiting for data"** (ini normal)

---

### Step 4: Enable Analytics

1. **Di Firebase Console sidebar**, click **Analytics**

2. **Analytics Dashboard**
   - Seharusnya sudah enabled (karena enable di Step 1.3)
   - Click **"DebugView"** (akan dipakai untuk testing nanti)

---

## ✅ Firebase Console Setup Complete!

Anda sekarang punya:
- ✅ Firebase project: **Fluxpert**
- ✅ Android app registered dengan package: `com.dicoding.ditonton`
- ✅ `google-services.json` downloaded
- ✅ Crashlytics enabled
- ✅ Analytics enabled

---

## 🔄 Next Steps (Dilakukan via Code)

**Setelah manual setup selesai, notify AI untuk lanjut:**

1. **Verifikasi file**:
   ```bash
   dir D:\Dicoding\Fluxpert01\android\app\google-services.json
   ```
   > File harus exist! Kalau tidak ada, re-download dari Firebase Console.

2. **Lanjut implementasi code**:
   - AI akan update dependencies
   - AI akan setup Firebase initialization
   - AI akan implement Crashlytics & Analytics

---

## 🧪 Testing Firebase (Nanti setelah code implementation)

### Test Crashlytics
1. Build & run app di device/emulator
2. Trigger test crash (via test button yang akan dibuat)
3. Buka Firebase Console → Crashlytics
4. Verify crash muncul (bisa 5-10 menit delay)

### Test Analytics
1. Enable Debug Mode:
   ```bash
   adb shell setprop debug.firebase.analytics.app com.dicoding.ditonton
   ```

2. Run app di device/emulator

3. Navigate beberapa pages (home → detail → watchlist)

4. Buka Firebase Console → Analytics → DebugView

5. Verify events muncul real-time (screen_view, custom events)

---

## ⚠️ Important Notes

### 🔒 Security
- **JANGAN commit `google-services.json` ke Git!**
- Add ke `.gitignore`:
  ```gitignore
  # Firebase
  android/app/google-services.json
  ios/Runner/GoogleService-Info.plist
  ```

### 📦 Package Name Must Match
- Firebase Console: `com.dicoding.ditonton`
- AndroidManifest.xml: `com.dicoding.ditonton`
- Kalau beda → Firebase tidak akan work!

### 🌐 Internet Permission
- Already in `AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.INTERNET" />
  ```

### 🐛 Crashlytics Data Delay
- First crash bisa delay 5-10 menit muncul di console
- Subsequent crashes lebih cepat (1-2 menit)
- Pastikan device/emulator ada internet connection

### 📊 Analytics DebugView
- Hanya show events dari devices yang enable Debug Mode
- Production events show di Analytics Dashboard (24 jam delay)
- DebugView = real-time testing tool

---

## 🆘 Troubleshooting

### "google-services.json not found"
- **Solution**: Re-download dari Firebase Console
- Place di: `android/app/google-services.json` (bukan `android/`)

### "Package name doesn't match"
- **Check**: `android/app/src/main/AndroidManifest.xml`
- Should be: `package="com.dicoding.ditonton"`
- Must match Firebase Console registration

### Build error: "Crashlytics plugin error"
- **Solution**: Run `flutter clean && flutter pub get`
- Re-build: `flutter build apk --debug`

### Analytics events not showing
- **Check**: Debug Mode enabled via adb command
- **Check**: Device has internet connection
- **Wait**: DebugView can take 1-2 minutes to update

### Crashlytics crash not showing
- **Wait**: First crash can take 5-10 minutes
- **Check**: Firebase Console → Crashlytics → Crashes tab
- **Verify**: App has internet when crash occurred

---

## 📚 Additional Resources

- [FlutterFire Documentation](https://firebase.flutter.dev)
- [Firebase Console](https://console.firebase.google.com)
- [Crashlytics Documentation](https://firebase.google.com/docs/crashlytics)
- [Analytics Documentation](https://firebase.google.com/docs/analytics)

---

## ✅ Checklist

Setup di Firebase Console:
- [ ] Create Firebase project
- [ ] Add Android app dengan package name: `com.dicoding.ditonton`
- [ ] Download `google-services.json`
- [ ] Place file di `android/app/google-services.json`
- [ ] Enable Crashlytics
- [ ] Enable Analytics

**Setelah checklist ini selesai, notify AI untuk lanjut ke code implementation!** 🚀
