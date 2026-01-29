# 🔄 GitHub Account Migration Guide - Resolve CI/CD Billing Issue

## 📋 Overview

Migrate project ke GitHub account baru untuk resolve billing issue dan activate CI/CD workflow.

---

## ✅ Prerequisites

Sebelum mulai, pastikan:
- [ ] Punya GitHub account lain yang aktif (free tier OK)
- [ ] Git installed di komputer (`git --version`)
- [ ] Sudah login GitHub account baru di browser
- [ ] Project di `D:\Dicoding\Fluxpert01` sudah complete

---

## 🚀 Step-by-Step Migration

### Step 1: Prepare Project Files

**1.1 Backup Current State**
```bash
cd D:\Dicoding\Fluxpert01

# Verify all changes committed locally (optional)
git status
```

**1.2 Update README (Optional - Replace badges)**
```bash
# Replace README_NEW.md dengan README.md
copy README.md README_OLD_BACKUP.md
copy README_NEW.md README.md
```

**1.3 Verify .gitignore**
```bash
# Check firebase config not tracked
type .gitignore | findstr "google-services.json"

# Should show: android/app/google-services.json
```

---

### Step 2: Create New GitHub Repository

**2.1 Login ke GitHub Account Baru**
- Go to: https://github.com
- Login dengan account yang mau dipakai
- Verify account aktif dan tidak ada billing issues

**2.2 Create New Repository**
- Click **"New"** (green button) atau **"+"** → **"New repository"**
- Repository name: `fluxpert` (atau nama lain)
- Description: `Flutter Movie & TV Series Catalog App - Dicoding Submission`
- Visibility: 
  - ✅ **Public** (Recommended - free CI/CD unlimited)
  - ❌ Private (may have billing issues)
- ❌ DO NOT initialize with README, .gitignore, or license
- Click **"Create repository"**

**2.3 Copy Repository URL**
Repository akan punya URL seperti:
```
https://github.com/YOUR_NEW_USERNAME/fluxpert.git
```
Copy URL ini untuk Step 3!

---

### Step 3: Initialize Local Git & Push

**3.1 Initialize Git (if not already)**
```bash
cd D:\Dicoding\Fluxpert01

# Check if already initialized
git status

# If not initialized, init now:
git init
```

**3.2 Add Remote (New GitHub Account)**
```bash
# Remove old remote if exists
git remote remove origin

# Add new remote
git remote add origin https://github.com/YOUR_NEW_USERNAME/fluxpert.git

# Verify remote
git remote -v
```

**3.3 Stage All Files**
```bash
# Add all files (respects .gitignore)
git add .

# Verify what will be committed
git status
```

**IMPORTANT:** Verify `google-services.json` NOT in staged files!
```bash
git status | findstr "google-services.json"
# Should show NOTHING (file ignored)
```

**3.4 Commit Changes**
```bash
git commit -m "Initial commit: Flutter Movie & TV Series App (Dicoding Submission)

Features:
- Clean Architecture with Modularization
- BLoC Pattern (TV Series) + Provider (Movies)
- Firebase Crashlytics + Analytics
- SSL Pinning (Native Dart)
- CI/CD with GitHub Actions
- 141 tests with 70.98% coverage
- Integration tests (5 scenarios)

TASK-1: TV Series (7/7 complete)
TASK-2: Advanced Features (6/6 complete)"
```

**3.5 Create Main Branch & Push**
```bash
# Create main branch
git branch -M main

# Push to GitHub
git push -u origin main
```

**Authentication:**
GitHub will prompt for authentication:
- **Username**: Your new GitHub username
- **Password**: Use **Personal Access Token** (NOT your password!)

**How to create Personal Access Token:**
1. GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Name: `Fluxpert Project`
4. Scopes: Select `repo` (full control)
5. Click "Generate token"
6. **COPY TOKEN** (will only show once!)
7. Use token as password when git push prompts

---

### Step 4: Verify Upload Success

**4.1 Check Repository on GitHub**
- Go to: `https://github.com/YOUR_NEW_USERNAME/fluxpert`
- Verify files uploaded:
  - ✅ `lib/`, `test/`, `android/`, etc.
  - ✅ `.github/workflows/ci.yml`
  - ✅ `README.md`
  - ❌ `google-services.json` (should NOT be there!)

**4.2 Check CI/CD Workflow**
- Go to **"Actions"** tab
- Should see workflow run starting automatically
- Status: 🟡 Running or ✅ Passed

**4.3 Wait for CI/CD to Complete**
- First run takes ~5-10 minutes
- Click on workflow run to see progress
- Jobs: `build-and-test` & `code-quality`

---

### Step 5: Update Badge URLs

**5.1 Get Correct Badge URL**
Your repository URL:
```
https://github.com/YOUR_NEW_USERNAME/fluxpert
```

Badge URL format:
```
https://github.com/YOUR_NEW_USERNAME/fluxpert/workflows/Flutter%20CI%2FCD/badge.svg
```

**5.2 Update README.md**
```bash
# Edit README.md
# Find line 3:
# [![Flutter CI/CD](https://github.com/YOUR_USERNAME/fluxpert/workflows/...

# Replace YOUR_USERNAME with actual username
# Save file
```

**5.3 Commit Badge Update**
```bash
git add README.md
git commit -m "Update CI/CD badge URLs"
git push
```

---

### Step 6: Verify CI/CD Works

**6.1 Check Actions Tab**
- Go to: `https://github.com/YOUR_NEW_USERNAME/fluxpert/actions`
- Latest workflow should be ✅ **green** (passed)

**6.2 Check Workflow Details**
Click on latest workflow run:
- ✅ `build-and-test` job should pass
- ✅ `code-quality` job should pass
- ✅ All 141 tests passed
- ✅ APK artifact available for download

**6.3 Download APK (Optional)**
- Scroll to bottom of workflow run page
- Under **"Artifacts"**: Click `debug-apk`
- Downloads ZIP with APK file
- Extract and install on Android device

---

## 🎯 Verification Checklist

**Repository Setup:**
- [ ] Repository created on new GitHub account
- [ ] Repository is **Public** (for free CI/CD)
- [ ] All files pushed successfully
- [ ] `google-services.json` NOT in repository (security!)
- [ ] `.github/workflows/ci.yml` exists

**CI/CD Status:**
- [ ] GitHub Actions tab shows workflow runs
- [ ] Latest workflow run is ✅ green (passed)
- [ ] All 141 tests passed in CI
- [ ] APK artifact available for download
- [ ] No billing errors

**Documentation:**
- [ ] README badge URLs updated
- [ ] Badge shows passing status (green)
- [ ] Repository has proper description

---

## 🆘 Troubleshooting

### Issue 1: Git Push Authentication Failed
```
remote: Support for password authentication was removed
```

**Solution:**
Use Personal Access Token instead of password!
1. GitHub → Settings → Developer settings → Personal access tokens
2. Generate new token with `repo` scope
3. Copy token
4. Use token as password when pushing

### Issue 2: CI/CD Not Running
```
No workflows found
```

**Solution:**
- Verify `.github/workflows/ci.yml` exists
- Check repository is Public (Private may have limits)
- Push a new commit to trigger workflow:
  ```bash
  git commit --allow-empty -m "Trigger CI/CD"
  git push
  ```

### Issue 3: Workflow Failed - Tests
```
Some tests failed
```

**Solution:**
- Tests pass locally but fail in CI? Check:
  - Flutter version in workflow (3.27.1)
  - All dependencies installed (`flutter pub get`)
  - Mock files generated (`build_runner`)

**Fix in workflow:**
```yaml
# Add to .github/workflows/ci.yml before flutter test
- name: Generate mocks
  run: flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue 4: google-services.json Committed Accidentally
```
ERROR: Firebase config file in repository!
```

**Solution:**
```bash
# Remove from git tracking (keeps local file)
git rm --cached android/app/google-services.json

# Commit removal
git commit -m "Remove Firebase config from tracking"
git push

# Verify .gitignore has:
android/app/google-services.json
```

### Issue 5: Badge Not Updating
```
Badge shows "no status"
```

**Solution:**
- Wait 5-10 minutes for first workflow to complete
- Hard refresh browser (Ctrl+F5)
- Check badge URL format is correct
- Workflow name in badge must match workflow file name

---

## 📊 Expected Results

After successful migration:

**GitHub Repository:**
- ✅ All source code uploaded
- ✅ 141 tests passing in CI
- ✅ Green CI/CD badge in README
- ✅ APK available for download
- ✅ No Firebase secrets exposed

**CI/CD Workflow:**
- ✅ Runs automatically on push
- ✅ Runs automatically on PR
- ✅ All jobs complete successfully
- ✅ Generates artifacts (APK, reports)
- ✅ No billing errors

**Security:**
- ✅ `google-services.json` not in repo
- ✅ `.gitignore` properly configured
- ✅ No API keys exposed
- ✅ No sensitive data in commits

---

## 🎓 For Dicoding Submission

**After successful migration:**

1. **Repository URL**
   - Submit: `https://github.com/YOUR_NEW_USERNAME/fluxpert`

2. **CI/CD Evidence**
   - Screenshot: Actions tab showing ✅ passed workflows
   - Screenshot: Green CI/CD badge in README

3. **APK Download**
   - Download from Actions → Artifacts
   - Or create Release with APK attached

4. **Documentation**
   - README.md shows complete features
   - All criteria documented (13/13 complete)
   - Firebase setup guides included

---

## 🚀 Quick Reference Commands

**One-time Setup (New Account):**
```bash
cd D:\Dicoding\Fluxpert01
git init
git remote add origin https://github.com/YOUR_NEW_USERNAME/fluxpert.git
git add .
git commit -m "Initial commit: Dicoding Flutter Expert submission"
git branch -M main
git push -u origin main
```

**Future Updates:**
```bash
git add .
git commit -m "Your commit message"
git push
```

**Check Status:**
```bash
git status                # Local changes
git remote -v            # Remote repository
git log --oneline        # Commit history
```

---

## ✅ Success Indicators

You'll know migration is successful when:

1. ✅ Repository accessible at `https://github.com/YOUR_NEW_USERNAME/fluxpert`
2. ✅ Actions tab shows green checkmark ✓
3. ✅ Badge in README shows "passing" (green)
4. ✅ No billing warnings
5. ✅ APK downloadable from Artifacts
6. ✅ 141 tests passing in CI
7. ✅ No Firebase secrets in repo

---

## 🎉 After Successful Migration

**Celebrate! 🎊 Then:**

1. ✅ Update Dicoding submission with new repo URL
2. ✅ Share repo link for review
3. ✅ Download APK for testing/demo
4. ✅ Create demo video/screenshots
5. ✅ Submit to Dicoding! 🎓

**Project is now:**
- ✅ Fully working
- ✅ CI/CD verified
- ✅ Properly documented
- ✅ Ready for submission

---

**Good luck with your submission!** 🚀
