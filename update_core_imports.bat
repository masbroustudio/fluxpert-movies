@echo off
setlocal enabledelayedexpansion

echo ========================================
echo PHASE 5: Update Import Paths (CORE)
echo ========================================
echo.

cd /d "%~dp0lib\core"

echo [1/3] Updating imports in core/common files...

REM Update constants.dart - no changes needed (no imports)

REM Update exception.dart - no changes needed (no imports)

REM Update failure.dart
powershell -Command "(Get-Content 'common\failure.dart') -replace 'package:ditonton/common/', 'package:ditonton/core/common/' | Set-Content 'common\failure.dart'"

REM Update state_enum.dart - no changes needed (no imports)

REM Update utils.dart - no changes needed (no imports to ditonton)

REM Update genre.dart
powershell -Command "(Get-Content 'common\genre.dart') -replace 'package:ditonton/common/', 'package:ditonton/core/common/' | Set-Content 'common\genre.dart'"
powershell -Command "(Get-Content 'common\genre.dart') -replace 'package:ditonton/domain/entities/', 'package:ditonton/core/common/' | Set-Content 'common\genre.dart'"

REM Update genre_model.dart
powershell -Command "(Get-Content 'common\genre_model.dart') -replace 'package:ditonton/data/models/', 'package:ditonton/core/common/' | Set-Content 'common\genre_model.dart'"
powershell -Command "(Get-Content 'common\genre_model.dart') -replace 'package:ditonton/domain/entities/', 'package:ditonton/core/common/' | Set-Content 'common\genre_model.dart'"

REM Update about_page.dart
powershell -Command "(Get-Content 'common\about_page.dart') -replace 'package:ditonton/common/', 'package:ditonton/core/common/' | Set-Content 'common\about_page.dart'"
powershell -Command "(Get-Content 'common\about_page.dart') -replace 'package:ditonton/presentation/pages/', 'package:ditonton/core/common/' | Set-Content 'common\about_page.dart'"

echo ✓ Core common files updated

echo.
echo [2/3] Updating imports in core/database files...

REM Update database_helper.dart
powershell -Command "(Get-Content 'database\database_helper.dart') -replace 'package:ditonton/data/models/movie_table', 'package:ditonton/movie/data/models/movie_table' | Set-Content 'database\database_helper.dart'"
powershell -Command "(Get-Content 'database\database_helper.dart') -replace 'package:ditonton/data/models/tv_series_table', 'package:ditonton/tv_series/data/models/tv_series_table' | Set-Content 'database\database_helper.dart'"

echo ✓ Core database files updated

echo.
echo [3/3] core/di/injection.dart already updated manually
echo ✓ Core DI files up-to-date

echo.
echo ========================================
echo ✅ CORE IMPORTS UPDATED!
echo ========================================
echo.
echo Next: Run 'update_movie_imports.bat'
echo.
pause
