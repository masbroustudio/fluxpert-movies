@echo off
echo ========================================
echo DISABLE OLD PROVIDER TESTS (TEMPORARY)
echo ========================================
echo.
echo This script will rename old provider test files
echo so they won't be run until we convert them to BLoC tests
echo.

REM Rename provider test files
if exist "D:\Dicoding\Fluxpert01\test\presentation\provider\movie_detail_notifier_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\provider\movie_detail_notifier_test.dart" "movie_detail_notifier_test.dart.disabled"
    echo - Disabled movie_detail_notifier_test.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\provider\movie_list_notifier_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\provider\movie_list_notifier_test.dart" "movie_list_notifier_test.dart.disabled"
    echo - Disabled movie_list_notifier_test.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\provider\movie_search_notifier_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\provider\movie_search_notifier_test.dart" "movie_search_notifier_test.dart.disabled"
    echo - Disabled movie_search_notifier_test.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\provider\popular_movies_notifier_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\provider\popular_movies_notifier_test.dart" "popular_movies_notifier_test.dart.disabled"
    echo - Disabled popular_movies_notifier_test.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\provider\top_rated_movies_notifier_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\provider\top_rated_movies_notifier_test.dart" "top_rated_movies_notifier_test.dart.disabled"
    echo - Disabled top_rated_movies_notifier_test.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\provider\watchlist_movie_notifier_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\provider\watchlist_movie_notifier_test.dart" "watchlist_movie_notifier_test.dart.disabled"
    echo - Disabled watchlist_movie_notifier_test.dart
)

REM Rename page test files that depend on provider
if exist "D:\Dicoding\Fluxpert01\test\presentation\pages\movie_detail_page_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\pages\movie_detail_page_test.dart" "movie_detail_page_test.dart.disabled"
    echo - Disabled movie_detail_page_test.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\pages\movie_detail_page_test.mocks.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\pages\movie_detail_page_test.mocks.dart" "movie_detail_page_test.mocks.dart.disabled"
    echo - Disabled movie_detail_page_test.mocks.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\pages\popular_movies_page_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\pages\popular_movies_page_test.dart" "popular_movies_page_test.dart.disabled"
    echo - Disabled popular_movies_page_test.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\pages\popular_movies_page_test.mocks.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\pages\popular_movies_page_test.mocks.dart" "popular_movies_page_test.mocks.dart.disabled"
    echo - Disabled popular_movies_page_test.mocks.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\pages\top_rated_movies_page_test.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\pages\top_rated_movies_page_test.dart" "top_rated_movies_page_test.dart.disabled"
    echo - Disabled top_rated_movies_page_test.dart
)

if exist "D:\Dicoding\Fluxpert01\test\presentation\pages\top_rated_movies_page_test.mocks.dart" (
    ren "D:\Dicoding\Fluxpert01\test\presentation\pages\top_rated_movies_page_test.mocks.dart" "top_rated_movies_page_test.mocks.dart.disabled"
    echo - Disabled top_rated_movies_page_test.mocks.dart
)

REM Rename integration test
if exist "D:\Dicoding\Fluxpert01\integration_test\app_test.dart" (
    ren "D:\Dicoding\Fluxpert01\integration_test\app_test.dart" "app_test.dart.disabled"
    echo - Disabled app_test.dart (integration test)
)

echo.
echo ========================================
echo DONE!
echo ========================================
echo.
echo Old test files have been renamed with .disabled extension
echo They won't be run by flutter test anymore
echo.
echo To re-enable them later, just remove the .disabled extension
echo.
pause
