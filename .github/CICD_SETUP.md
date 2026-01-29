# GitHub Actions CI/CD Setup Guide

## Overview
This repository uses GitHub Actions for continuous integration and deployment.

## Workflow Files

### `.github/workflows/ci.yml`
Main CI/CD workflow that runs on every push and pull request.

**Jobs:**
1. **build-and-test** - Builds app and runs tests
   - Checkout code
   - Setup Java 11
   - Setup Flutter 3.27.1
   - Install dependencies
   - Check code formatting
   - Run static analysis
   - Run unit tests with coverage
   - Calculate coverage percentage
   - Build debug APK
   - Upload artifacts

2. **code-quality** - Additional quality checks
   - Check outdated dependencies
   - Generate analysis report
   - Upload reports as artifacts

## Badges

Add these badges to your README.md:

```markdown
![Flutter CI/CD](https://github.com/YOUR_USERNAME/YOUR_REPO/workflows/Flutter%20CI%2FCD/badge.svg)
![Flutter Version](https://img.shields.io/badge/Flutter-3.27.1-blue.svg)
![Tests](https://img.shields.io/badge/tests-141%20passing-success.svg)
![Coverage](https://img.shields.io/badge/coverage-70.98%25-green.svg)
```

Replace `YOUR_USERNAME` and `YOUR_REPO` with your GitHub username and repository name.

## Triggers

The workflow runs automatically on:
- Push to `main`, `master`, or `develop` branches
- Pull requests to `main`, `master`, or `develop` branches

## Requirements

### Repository Secrets (Optional)
For advanced features, you can add these secrets in GitHub repository settings:

- `CODECOV_TOKEN` - For Codecov integration (optional)
- `SLACK_WEBHOOK` - For Slack notifications (optional)

### Branch Protection (Recommended)
Consider enabling branch protection rules:
1. Go to repository Settings → Branches
2. Add rule for `main` branch
3. Enable "Require status checks to pass before merging"
4. Select "Build & Test" workflow

## Local Testing

Before pushing, test locally:

```bash
# Run tests
flutter test --coverage

# Run analysis
flutter analyze

# Check formatting
dart format --output=none --set-exit-if-changed .

# Build APK
flutter build apk --debug
```

## Artifacts

After each workflow run, you can download:
- **debug-apk** - Built APK file
- **analysis-report** - Static analysis results

Access artifacts from the Actions tab → Select workflow run → Artifacts section.

## Troubleshooting

### Build Failures
1. Check Java version (must be 11)
2. Check Flutter version (3.27.1)
3. Ensure all dependencies are compatible

### Test Failures
1. Tests must pass locally first
2. Check for environment-specific issues
3. Review test logs in Actions tab

### Coverage Issues
1. Coverage is calculated but won't fail the build
2. Codecov upload is optional and won't block CI

## Customization

### Change Flutter Version
Edit `.github/workflows/ci.yml`:
```yaml
flutter-version: '3.27.1'  # Change this
```

### Add More Checks
Add steps in the workflow file:
```yaml
- name: Custom check
  run: your-command-here
```

### Disable Specific Checks
Add `continue-on-error: true` to allow failures:
```yaml
- name: Optional check
  run: some-command
  continue-on-error: true
```

## Next Steps

1. **Commit and push** `.github/workflows/ci.yml` to your repository
2. **Check Actions tab** in GitHub to see workflow runs
3. **Add badges** to README.md
4. **Configure branch protection** (optional)
5. **Setup Codecov** for detailed coverage reports (optional)

## Support

For issues with GitHub Actions:
- Check [GitHub Actions documentation](https://docs.github.com/en/actions)
- Review workflow logs in Actions tab
- Check [Flutter CI/CD guide](https://flutter.dev/docs/deployment/cd)
