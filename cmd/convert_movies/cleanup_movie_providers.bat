@echo off
echo ========================================
echo CLEANUP MOVIE PROVIDER FILES
echo ========================================
echo.

REM Hapus provider files
del "D:\Dicoding\Fluxpert01\lib\movie\presentation\provider\movie_detail_notifier.dart" 2>nul
del "D:\Dicoding\Fluxpert01\lib\movie\presentation\provider\movie_list_notifier.dart" 2>nul
del "D:\Dicoding\Fluxpert01\lib\movie\presentation\provider\movie_search_notifier.dart" 2>nul
del "D:\Dicoding\Fluxpert01\lib\movie\presentation\provider\popular_movies_notifier.dart" 2>nul
del "D:\Dicoding\Fluxpert01\lib\movie\presentation\provider\top_rated_movies_notifier.dart" 2>nul
del "D:\Dicoding\Fluxpert01\lib\movie\presentation\provider\watchlist_movie_notifier.dart" 2>nul

REM Hapus folder provider jika kosong
rmdir "D:\Dicoding\Fluxpert01\lib\movie\presentation\provider" 2>nul

echo.
echo Provider files cleaned up successfully!
echo.
echo ========================================
echo NEXT STEPS:
echo ========================================
echo 1. Run: flutter pub get
echo 2. Run: flutter analyze
echo 3. Run: flutter run
echo ========================================
pause
