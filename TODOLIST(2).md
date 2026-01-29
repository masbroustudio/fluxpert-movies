# TODOLIST (2) - Advanced Features Implementation

Checklist untuk mengerjakan TASK-2.md dengan fitur-fitur advanced.

---

## 📋 Overview

| Kriteria | Status | Effort | Dependency |
|----------|--------|--------|------------|
| 1. CI/CD (GitHub Actions) | ⏳ TODO | MEDIUM | - |
| 2. SSL Pinning | ⏳ TODO | MEDIUM | TMDB Certificate |
| 3. Firebase Analytics | ⏳ TODO | LOW | Firebase Account |
| 4. Firebase Crashlytics | ⏳ TODO | LOW | Firebase Analytics |
| 5. BLoC State Management | ✅ DONE | - | TV Series already BLoC |
| 6. Modularisasi | ⏳ TODO | MEDIUM | - |

---

## ✅ Kriteria 5: BLoC State Management (SUDAH SELESAI)

- [x] ✅ TV Series menggunakan BLoC pattern
- [x] ✅ 6 BLoC implementations (OnTheAir, Popular, TopRated, Detail, Search, Watchlist)
- [x] ✅ Event & State management proper
- [x] ✅ Tests dengan bloc_test

**Status:** ✅ **MEMENUHI KRITERIA** - TV Series sudah full BLoC!

**Catatan:** Movies tetap menggunakan Provider (hybrid approach acceptable untuk submission).

---

## 🔄 Kriteria 1-4: Continuous Integration dengan GitHub Actions

### Phase 1: Setup GitHub Repository
- [ ] Push project ke GitHub (jika belum)
  ```bash
  git init
  git add .
  git commit -m "Initial commit with TV Series BLoC"
  git remote add origin https://github.com/YOUR_USERNAME/Fluxpert01.git
  git push -u origin main
  ```

### Phase 2: Create GitHub Actions Workflow
- [ ] Buat folder `.github/workflows/`
- [ ] Buat file `ci.yml` dengan konfigurasi Flutter CI
- [ ] Konfigurasi workflow:
  - [ ] Trigger on push & pull request
  - [ ] Setup Flutter environment
  - [ ] Run flutter pub get
  - [ ] Run flutter analyze
  - [ ] Run flutter test
  - [ ] Generate coverage report
  - [ ] Upload coverage (optional: Codecov)

### Phase 3: Test CI Pipeline
- [ ] Push changes ke GitHub
- [ ] Verify workflow runs automatically
- [ ] Check all tests pass
- [ ] Fix any CI-specific issues

### Phase 4: Add Build Status Badge
- [ ] Get badge URL dari GitHub Actions
- [ ] Add badge ke README.md
- [ ] Format: `[![CI Status](badge-url)](actions-url)`
- [ ] Commit & push

### Phase 5: Screenshot & Documentation
- [ ] Ambil screenshot dari successful build
- [ ] Screenshot harus include:
  - [ ] Workflow name
  - [ ] Build status (passing)
  - [ ] Test results
  - [ ] Timestamp
- [ ] Save screenshot ke folder `docs/screenshots/`
- [ ] Add reference di README

**Expected Output:**
- ✅ CI runs on every push
- ✅ All 141 tests pass automatically
- ✅ Badge showing "passing" status
- ✅ Screenshot documented

---

## 🔒 Kriteria 7: SSL Pinning Implementation

### Phase 1: Ekstrak TMDB SSL Certificate

#### **MANUAL STEP (ANDA YANG JALANKAN):**

**Option A: Via Chrome Browser**
1. Buka https://api.themoviedb.org di Chrome
2. Klik icon padlock (🔒) di address bar
3. Click "Certificate" → "Details"
4. Pilih "Copy to File" → Export as `.cer` (DER encoded)
5. Atau pilih "Export" → Save as `tmdb.cer`

**Option B: Via OpenSSL (Terminal)**
```bash
# Extract certificate
openssl s_client -servername api.themoviedb.org -connect api.themoviedb.org:443 </dev/null | openssl x509 -outform DER -out assets/certificates/tmdb.cer

# Get SHA-256 fingerprint
openssl x509 -inform DER -in assets/certificates/tmdb.cer -noout -fingerprint -sha256
```

**Option C: Via Firefox**
1. Buka https://api.themoviedb.org
2. Klik padlock → "More Information"
3. "View Certificate" → "Details"
4. "Export" → Save as PEM format
5. Convert PEM to DER:
   ```bash
   openssl x509 -in tmdb.pem -outform DER -out tmdb.cer
   ```

**Save Certificate:**
- [ ] Create folder `assets/certificates/`
- [ ] Save `tmdb.cer` di folder tersebut
- [ ] Commit certificate file ke repository

### Phase 2: Add SSL Pinning Dependencies
- [ ] Update `pubspec.yaml`:
  ```yaml
  dependencies:
    http_certificate_pinning: ^1.0.3
  ```
- [ ] Run `flutter pub get`

### Phase 3: Implement SSL Pinning
- [ ] Create `lib/common/ssl_pinning.dart`
  - [ ] Initialize certificate pinning
  - [ ] Configure allowed certificates
  - [ ] Create secure HTTP client

- [ ] Update Remote Data Sources:
  - [ ] `movie_remote_data_source.dart` - Use pinned client
  - [ ] `tv_series_remote_data_source.dart` - Use pinned client

- [ ] Test SSL connection:
  - [ ] Verify API calls work
  - [ ] Test with invalid cert (should fail)
  - [ ] Test with valid cert (should pass)

### Phase 4: Add SSL Certificate to Assets
- [ ] Update `pubspec.yaml`:
  ```yaml
  flutter:
    assets:
      - assets/certificates/tmdb.cer
  ```

**Expected Output:**
- ✅ HTTPS connections verified with certificate pinning
- ✅ Added security layer to API calls
- ✅ Protection against MITM attacks

---

## 📊 Kriteria 8: Firebase Analytics & Crashlytics

### Phase 1: Setup Firebase Console (MANUAL BY YOU)

#### **STEPS YANG ANDA KERJAKAN:**

1. **Create Firebase Project:**
   - [ ] Go to https://console.firebase.google.com/
   - [ ] Click "Add Project"
   - [ ] Project name: "Fluxpert" (atau nama lain)
   - [ ] Enable/Disable Google Analytics (optional untuk analytics)
   - [ ] Click "Create Project"

2. **Add Android App:**
   - [ ] Click "Add app" → Android icon
   - [ ] Android package name: `com.dicoding.fluxpert` (cek di `android/app/build.gradle`)
   - [ ] App nickname: "Fluxpert Android"
   - [ ] Click "Register app"

3. **Download Configuration File:**
   - [ ] Download `google-services.json`
   - [ ] Save ke folder: `android/app/google-services.json`
   - [ ] **JANGAN COMMIT** file ini ke GitHub (sensitive!)

4. **Add iOS App (Optional):**
   - [ ] Click "Add app" → iOS icon
   - [ ] iOS bundle ID: sama dengan Android package
   - [ ] Download `GoogleService-Info.plist`
   - [ ] Save ke `ios/Runner/GoogleService-Info.plist`

5. **Enable Firebase Services:**
   - [ ] Go to Firebase Console → Analytics
   - [ ] Enable Analytics
   - [ ] Go to Crashlytics
   - [ ] Enable Crashlytics

**Checklist:**
- [ ] Firebase project created
- [ ] `google-services.json` downloaded
- [ ] File placed in correct location
- [ ] Add to `.gitignore`:
  ```
  # Firebase
  android/app/google-services.json
  ios/Runner/GoogleService-Info.plist
  ```

### Phase 2: Add Firebase Dependencies
- [ ] Update `pubspec.yaml`:
  ```yaml
  dependencies:
    firebase_core: ^2.24.2
    firebase_analytics: ^10.8.0
    firebase_crashlytics: ^3.4.9
  ```
- [ ] Run `flutter pub get`

### Phase 3: Configure Android for Firebase
- [ ] Update `android/build.gradle`:
  ```gradle
  buildscript {
    dependencies {
      classpath 'com.google.gms:google-services:4.4.0'
      classpath 'com.google.firebase:firebase-crashlytics-gradle:2.9.9'
    }
  }
  ```

- [ ] Update `android/app/build.gradle`:
  ```gradle
  apply plugin: 'com.google.gms.google-services'
  apply plugin: 'com.google.firebase.crashlytics'
  ```

### Phase 4: Initialize Firebase in App
- [ ] Update `lib/main.dart`:
  - [ ] Add Firebase initialization
  - [ ] Initialize Analytics
  - [ ] Initialize Crashlytics
  - [ ] Add FlutterError handler

### Phase 5: Implement Analytics Events
- [ ] Create `lib/common/analytics_helper.dart`
  - [ ] Log screen views
  - [ ] Log custom events
  - [ ] Log user properties

- [ ] Add analytics tracking:
  - [ ] Track movie detail views
  - [ ] Track TV series detail views
  - [ ] Track search queries
  - [ ] Track watchlist actions

### Phase 6: Test Crashlytics
- [ ] Add test crash button (development only)
- [ ] Trigger test crash
- [ ] Verify crash appears in Firebase Console
- [ ] Remove test crash code before submission

**Expected Output:**
- ✅ Firebase integrated
- ✅ Analytics tracking user behavior
- ✅ Crashlytics capturing errors
- ✅ Developer can monitor app stability

---

## 📦 Kriteria 9: Modularisasi (Simple Folder Structure)

### Phase 1: Planning Module Structure
- [ ] Design folder structure:
  ```
  lib/
  ├── core/                 # Shared utilities
  │   ├── common/          # Constants, utils, exceptions
  │   ├── network/         # HTTP client, SSL
  │   ├── database/        # SQLite helper
  │   └── di/              # Dependency injection
  ├── movie/               # Movie feature module
  │   ├── data/
  │   │   ├── models/
  │   │   ├── datasources/
  │   │   └── repositories/
  │   ├── domain/
  │   │   ├── entities/
  │   │   ├── repositories/
  │   │   └── usecases/
  │   └── presentation/
  │       ├── pages/
  │       ├── provider/
  │       └── widgets/
  └── tv_series/           # TV Series feature module
      ├── data/
      │   ├── models/
      │   ├── datasources/
      │   └── repositories/
      ├── domain/
      │   ├── entities/
      │   ├── repositories/
      │   └── usecases/
      └── presentation/
          ├── pages/
          ├── bloc/
          └── widgets/
  ```

### Phase 2: Move Core Files
- [ ] Create `lib/core/` folder structure
- [ ] Move common utilities:
  - [ ] Move `common/` → `core/common/`
  - [ ] Move `injection.dart` → `core/di/injection.dart`
  - [ ] Create `core/network/http_ssl_pinning.dart`
  - [ ] Move `data/datasources/db/` → `core/database/`

### Phase 3: Separate Movie Module
- [ ] Create `lib/movie/` structure
- [ ] Move Movie files:
  - [ ] Move `data/models/movie*.dart` → `movie/data/models/`
  - [ ] Move `data/datasources/movie_*.dart` → `movie/data/datasources/`
  - [ ] Move `data/repositories/movie_*.dart` → `movie/data/repositories/`
  - [ ] Move `domain/entities/movie*.dart` → `movie/domain/entities/`
  - [ ] Move `domain/repositories/movie_*.dart` → `movie/domain/repositories/`
  - [ ] Move `domain/usecases/*movie*.dart` → `movie/domain/usecases/`
  - [ ] Move `presentation/provider/*movie*.dart` → `movie/presentation/provider/`
  - [ ] Move `presentation/pages/*movie*.dart` → `movie/presentation/pages/`
  - [ ] Move `presentation/widgets/movie_*.dart` → `movie/presentation/widgets/`

### Phase 4: Separate TV Series Module
- [ ] Create `lib/tv_series/` structure
- [ ] Move TV Series files:
  - [ ] Move `data/models/tv_series*.dart` → `tv_series/data/models/`
  - [ ] Move `data/datasources/tv_series_*.dart` → `tv_series/data/datasources/`
  - [ ] Move `data/repositories/tv_series_*.dart` → `tv_series/data/repositories/`
  - [ ] Move `domain/entities/tv_series*.dart` → `tv_series/domain/entities/`
  - [ ] Move `domain/repositories/tv_series_*.dart` → `tv_series/domain/repositories/`
  - [ ] Move `domain/usecases/*tv_series*.dart` → `tv_series/domain/usecases/`
  - [ ] Move `presentation/bloc/*tv_series*.dart` → `tv_series/presentation/bloc/`
  - [ ] Move `presentation/pages/*tv_series*.dart` → `tv_series/presentation/pages/`
  - [ ] Move `presentation/widgets/tv_series_*.dart` → `tv_series/presentation/widgets/`

### Phase 5: Update All Import Paths
- [ ] Update imports in Movie module
  - [ ] Change to relative imports within module
  - [ ] Update core imports: `package:ditonton/core/...`
  
- [ ] Update imports in TV Series module
  - [ ] Change to relative imports within module
  - [ ] Update core imports: `package:ditonton/core/...`

- [ ] Update `main.dart` imports
- [ ] Update `injection.dart` imports
- [ ] Update test imports

### Phase 6: Update Dependency Injection
- [ ] Reorganize `core/di/injection.dart`:
  - [ ] Separate Movie DI
  - [ ] Separate TV Series DI
  - [ ] Shared Core DI

### Phase 7: Update Tests Structure
- [ ] Reorganize test folder:
  ```
  test/
  ├── core/           # Core tests
  ├── movie/          # Movie module tests
  └── tv_series/      # TV Series module tests
  ```
- [ ] Move test files to match new structure
- [ ] Update test imports

### Phase 8: Verify Everything Works
- [ ] Run `flutter analyze` - No errors
- [ ] Run `flutter test` - All 141 tests pass
- [ ] Run app - UI works correctly
- [ ] Test all features:
  - [ ] Movie list, detail, search, watchlist
  - [ ] TV Series list, detail, search, watchlist
- [ ] Verify navigation between modules

**Expected Output:**
- ✅ Clean separation between Movie & TV Series
- ✅ Shared utilities in Core module
- ✅ Better code organization
- ✅ Easier maintenance & scalability

---

## 📝 Documentation Updates

### Update README.md
- [ ] Add CI/CD badge
- [ ] Add section "Advanced Features"
  - [ ] CI/CD with GitHub Actions
  - [ ] SSL Pinning
  - [ ] Firebase Analytics & Crashlytics
  - [ ] Modular Architecture
- [ ] Update project structure diagram
- [ ] Add Firebase setup instructions

### Create Additional Documentation
- [ ] Create `docs/CI_CD_SETUP.md`
  - [ ] GitHub Actions configuration
  - [ ] Badge setup
  - [ ] Troubleshooting
  
- [ ] Create `docs/SSL_PINNING.md`
  - [ ] Certificate extraction guide
  - [ ] Implementation details
  - [ ] Testing SSL pinning
  
- [ ] Create `docs/FIREBASE_SETUP.md`
  - [ ] Firebase Console setup
  - [ ] Configuration files
  - [ ] Analytics events list
  - [ ] Crashlytics testing
  
- [ ] Create `docs/MODULARIZATION.md`
  - [ ] Architecture overview
  - [ ] Module structure
  - [ ] Import guidelines

---

## 🧪 Testing Strategy

### Test CI/CD
- [ ] Push code changes
- [ ] Verify workflow triggers
- [ ] Check all tests pass
- [ ] Verify coverage generation

### Test SSL Pinning
- [ ] Test with correct certificate - Should work
- [ ] Test with wrong/expired cert - Should fail
- [ ] Verify no MITM possible

### Test Firebase
- [ ] Verify Analytics events in Firebase Console
- [ ] Trigger test crash
- [ ] Check Crashlytics dashboard
- [ ] Verify crash reports appear

### Test Modularization
- [ ] All imports resolved
- [ ] No circular dependencies
- [ ] All tests still pass
- [ ] App runs without errors

---

## ⚠️ Important Notes & Warnings

### Security
- **NEVER commit `google-services.json` to public repository!**
- Add to `.gitignore`:
  ```
  android/app/google-services.json
  ios/Runner/GoogleService-Info.plist
  ```

### GitHub Actions
- First run might take 5-10 minutes
- Check "Actions" tab for logs
- Fix any failing tests before proceeding

### SSL Pinning
- Certificate expires - need to update periodically
- Keep backup of certificate extraction method
- Test thoroughly before deployment

### Firebase
- Analytics data delayed (24-48 hours)
- Crashlytics needs app restart to send reports
- Test mode available for instant verification

### Modularization
- **BIG REFACTOR** - Take time, be careful!
- Test after each phase
- Commit frequently
- Keep backup before starting

---

## 📊 Progress Tracking

### Estimated Time
| Task | Time | Complexity |
|------|------|------------|
| CI/CD Setup | 2-3 hours | Medium |
| SSL Pinning | 1-2 hours | Low |
| Firebase Setup | 2-3 hours | Medium |
| Modularization | 4-6 hours | High |
| Testing & Fixes | 2-3 hours | Medium |
| **TOTAL** | **11-17 hours** | - |

### Current Progress
```
Overall: 1/6 criteria complete (16.7%)

✅ BLoC (TV Series) - DONE
⏳ CI/CD - TODO
⏳ SSL Pinning - TODO  
⏳ Firebase - TODO
⏳ Modularization - TODO
```

---

## 🎯 Success Criteria

### Definition of Done
- [x] ✅ BLoC state management (TV Series implemented)
- [ ] CI/CD pipeline working (badge showing "passing")
- [ ] All tests run automatically on push
- [ ] SSL pinning active on API calls
- [ ] Firebase Analytics tracking events
- [ ] Firebase Crashlytics capturing crashes
- [ ] Code organized in modules (movie, tv_series, core)
- [ ] All 141+ tests still passing
- [ ] Documentation complete
- [ ] Screenshots captured

### Submission Checklist
- [ ] GitHub repository public/accessible
- [ ] CI badge visible in README
- [ ] Screenshot of successful build included
- [ ] `google-services.json` in `.gitignore` (not committed!)
- [ ] SSL certificate committed (in assets folder)
- [ ] Firebase project created & configured
- [ ] Modular structure implemented
- [ ] All tests passing
- [ ] App runs successfully
- [ ] Documentation updated

---

## 🚀 Quick Start Commands

```bash
# 1. Setup GitHub Actions (after creating workflow file)
git add .github/workflows/ci.yml
git commit -m "Add CI/CD with GitHub Actions"
git push

# 2. Add SSL Pinning dependencies
flutter pub add http_certificate_pinning
flutter pub get

# 3. Add Firebase dependencies
flutter pub add firebase_core firebase_analytics firebase_crashlytics
flutter pub get

# 4. Run tests after changes
flutter test

# 5. Analyze code
flutter analyze

# 6. Check coverage
flutter test --coverage
dart calculate_coverage.dart

# 7. Run app
flutter run
```

---

## 📞 Need Help?

### Common Issues & Solutions

**Issue: CI tests failing**
- Check Flutter version in workflow matches local
- Verify all dependencies in pubspec.yaml
- Check test file imports

**Issue: SSL pinning not working**
- Verify certificate file location
- Check certificate not expired
- Confirm SHA-256 fingerprint matches

**Issue: Firebase not connecting**
- Verify `google-services.json` in correct location
- Check package name matches
- Ensure Firebase services enabled in console

**Issue: Modularization breaks app**
- Check all import paths updated
- Verify no circular dependencies
- Test incrementally, don't move all at once

---

**Good luck with the advanced features implementation!** 🚀

**Tips:**
- Work on one criteria at a time
- Test frequently
- Commit after each working phase
- Ask if stuck on any step!
