@echo off
echo ========================================
echo PHASE 3: Moving MOVIE Module Files
echo ========================================
echo.

cd /d "%~dp0"

echo [1/7] Moving movie entities...
move /Y "lib\domain\entities\movie.dart" "lib\movie\domain\entities\movie.dart"
move /Y "lib\domain\entities\movie_detail.dart" "lib\movie\domain\entities\movie_detail.dart"
echo ✓ Movie entities moved

echo.
echo [2/7] Moving movie repository interface...
move /Y "lib\domain\repositories\movie_repository.dart" "lib\movie\domain\repositories\movie_repository.dart"
echo ✓ Movie repository interface moved

echo.
echo [3/7] Moving movie use cases...
move /Y "lib\domain\usecases\get_movie_detail.dart" "lib\movie\domain\usecases\get_movie_detail.dart"
move /Y "lib\domain\usecases\get_movie_recommendations.dart" "lib\movie\domain\usecases\get_movie_recommendations.dart"
move /Y "lib\domain\usecases\get_now_playing_movies.dart" "lib\movie\domain\usecases\get_now_playing_movies.dart"
move /Y "lib\domain\usecases\get_popular_movies.dart" "lib\movie\domain\usecases\get_popular_movies.dart"
move /Y "lib\domain\usecases\get_top_rated_movies.dart" "lib\movie\domain\usecases\get_top_rated_movies.dart"
move /Y "lib\domain\usecases\get_watchlist_movies.dart" "lib\movie\domain\usecases\get_watchlist_movies.dart"
move /Y "lib\domain\usecases\get_watchlist_status.dart" "lib\movie\domain\usecases\get_watchlist_status.dart"
move /Y "lib\domain\usecases\remove_watchlist.dart" "lib\movie\domain\usecases\remove_watchlist.dart"
move /Y "lib\domain\usecases\save_watchlist.dart" "lib\movie\domain\usecases\save_watchlist.dart"
move /Y "lib\domain\usecases\search_movies.dart" "lib\movie\domain\usecases\search_movies.dart"
echo ✓ Movie use cases moved

echo.
echo [4/7] Moving movie models...
move /Y "lib\data\models\movie_model.dart" "lib\movie\data\models\movie_model.dart"
move /Y "lib\data\models\movie_detail_model.dart" "lib\movie\data\models\movie_detail_model.dart"
move /Y "lib\data\models\movie_response.dart" "lib\movie\data\models\movie_response.dart"
move /Y "lib\data\models\movie_table.dart" "lib\movie\data\models\movie_table.dart"
echo ✓ Movie models moved

echo.
echo [5/7] Moving movie data sources...
move /Y "lib\data\datasources\movie_local_data_source.dart" "lib\movie\data\datasources\movie_local_data_source.dart"
move /Y "lib\data\datasources\movie_remote_data_source.dart" "lib\movie\data\datasources\movie_remote_data_source.dart"
echo ✓ Movie data sources moved

echo.
echo [6/7] Moving movie repository implementation...
move /Y "lib\data\repositories\movie_repository_impl.dart" "lib\movie\data\repositories\movie_repository_impl.dart"
echo ✓ Movie repository implementation moved

echo.
echo [7/7] Moving movie presentation...
move /Y "lib\presentation\pages\home_movie_page.dart" "lib\movie\presentation\pages\home_movie_page.dart"
move /Y "lib\presentation\pages\movie_detail_page.dart" "lib\movie\presentation\pages\movie_detail_page.dart"
move /Y "lib\presentation\pages\popular_movies_page.dart" "lib\movie\presentation\pages\popular_movies_page.dart"
move /Y "lib\presentation\pages\top_rated_movies_page.dart" "lib\movie\presentation\pages\top_rated_movies_page.dart"
move /Y "lib\presentation\pages\search_page.dart" "lib\movie\presentation\pages\search_page.dart"
move /Y "lib\presentation\pages\watchlist_movies_page.dart" "lib\movie\presentation\pages\watchlist_movies_page.dart"

move /Y "lib\presentation\provider\movie_detail_notifier.dart" "lib\movie\presentation\provider\movie_detail_notifier.dart"
move /Y "lib\presentation\provider\movie_list_notifier.dart" "lib\movie\presentation\provider\movie_list_notifier.dart"
move /Y "lib\presentation\provider\movie_search_notifier.dart" "lib\movie\presentation\provider\movie_search_notifier.dart"
move /Y "lib\presentation\provider\popular_movies_notifier.dart" "lib\movie\presentation\provider\popular_movies_notifier.dart"
move /Y "lib\presentation\provider\top_rated_movies_notifier.dart" "lib\movie\presentation\provider\top_rated_movies_notifier.dart"
move /Y "lib\presentation\provider\watchlist_movie_notifier.dart" "lib\movie\presentation\provider\watchlist_movie_notifier.dart"

move /Y "lib\presentation\widgets\movie_card_list.dart" "lib\movie\presentation\widgets\movie_card_list.dart"
echo ✓ Movie presentation moved

echo.
echo ========================================
echo ✅ PHASE 3 COMPLETE!
echo ========================================
echo.
echo Next: Run 'migrate_tv_series_files.bat'
echo.
pause
