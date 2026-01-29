@echo off
echo ========================================
echo PHASE 4: Moving TV SERIES Module Files
echo ========================================
echo.

cd /d "%~dp0"

echo [1/7] Moving TV Series entities...
move /Y "lib\domain\entities\tv_series.dart" "lib\tv_series\domain\entities\tv_series.dart"
move /Y "lib\domain\entities\tv_series_detail.dart" "lib\tv_series\domain\entities\tv_series_detail.dart"
echo ✓ TV Series entities moved

echo.
echo [2/7] Moving TV Series repository interface...
move /Y "lib\domain\repositories\tv_series_repository.dart" "lib\tv_series\domain\repositories\tv_series_repository.dart"
echo ✓ TV Series repository interface moved

echo.
echo [3/7] Moving TV Series use cases...
move /Y "lib\domain\usecases\get_on_the_air_tv_series.dart" "lib\tv_series\domain\usecases\get_on_the_air_tv_series.dart"
move /Y "lib\domain\usecases\get_popular_tv_series.dart" "lib\tv_series\domain\usecases\get_popular_tv_series.dart"
move /Y "lib\domain\usecases\get_top_rated_tv_series.dart" "lib\tv_series\domain\usecases\get_top_rated_tv_series.dart"
move /Y "lib\domain\usecases\get_tv_series_detail.dart" "lib\tv_series\domain\usecases\get_tv_series_detail.dart"
move /Y "lib\domain\usecases\get_tv_series_recommendations.dart" "lib\tv_series\domain\usecases\get_tv_series_recommendations.dart"
move /Y "lib\domain\usecases\get_watchlist_tv_series.dart" "lib\tv_series\domain\usecases\get_watchlist_tv_series.dart"
move /Y "lib\domain\usecases\get_watchlist_tv_series_status.dart" "lib\tv_series\domain\usecases\get_watchlist_tv_series_status.dart"
move /Y "lib\domain\usecases\remove_tv_series_watchlist.dart" "lib\tv_series\domain\usecases\remove_tv_series_watchlist.dart"
move /Y "lib\domain\usecases\save_tv_series_watchlist.dart" "lib\tv_series\domain\usecases\save_tv_series_watchlist.dart"
move /Y "lib\domain\usecases\search_tv_series.dart" "lib\tv_series\domain\usecases\search_tv_series.dart"
echo ✓ TV Series use cases moved

echo.
echo [4/7] Moving TV Series models...
move /Y "lib\data\models\tv_series_model.dart" "lib\tv_series\data\models\tv_series_model.dart"
move /Y "lib\data\models\tv_series_detail_model.dart" "lib\tv_series\data\models\tv_series_detail_model.dart"
move /Y "lib\data\models\tv_series_response.dart" "lib\tv_series\data\models\tv_series_response.dart"
move /Y "lib\data\models\tv_series_table.dart" "lib\tv_series\data\models\tv_series_table.dart"
echo ✓ TV Series models moved

echo.
echo [5/7] Moving TV Series data sources...
move /Y "lib\data\datasources\tv_series_local_data_source.dart" "lib\tv_series\data\datasources\tv_series_local_data_source.dart"
move /Y "lib\data\datasources\tv_series_remote_data_source.dart" "lib\tv_series\data\datasources\tv_series_remote_data_source.dart"
echo ✓ TV Series data sources moved

echo.
echo [6/7] Moving TV Series repository implementation...
move /Y "lib\data\repositories\tv_series_repository_impl.dart" "lib\tv_series\data\repositories\tv_series_repository_impl.dart"
echo ✓ TV Series repository implementation moved

echo.
echo [7/7] Moving TV Series presentation...
move /Y "lib\presentation\pages\home_tv_series_page.dart" "lib\tv_series\presentation\pages\home_tv_series_page.dart"
move /Y "lib\presentation\pages\tv_series_detail_page.dart" "lib\tv_series\presentation\pages\tv_series_detail_page.dart"
move /Y "lib\presentation\pages\popular_tv_series_page.dart" "lib\tv_series\presentation\pages\popular_tv_series_page.dart"
move /Y "lib\presentation\pages\top_rated_tv_series_page.dart" "lib\tv_series\presentation\pages\top_rated_tv_series_page.dart"
move /Y "lib\presentation\pages\on_the_air_tv_series_page.dart" "lib\tv_series\presentation\pages\on_the_air_tv_series_page.dart"
move /Y "lib\presentation\pages\search_tv_series_page.dart" "lib\tv_series\presentation\pages\search_tv_series_page.dart"
move /Y "lib\presentation\pages\watchlist_tv_series_page.dart" "lib\tv_series\presentation\pages\watchlist_tv_series_page.dart"

move /Y "lib\presentation\bloc\on_the_air_tv_series_bloc.dart" "lib\tv_series\presentation\bloc\on_the_air_tv_series_bloc.dart"
move /Y "lib\presentation\bloc\on_the_air_tv_series_event_state.dart" "lib\tv_series\presentation\bloc\on_the_air_tv_series_event_state.dart"
move /Y "lib\presentation\bloc\popular_tv_series_bloc.dart" "lib\tv_series\presentation\bloc\popular_tv_series_bloc.dart"
move /Y "lib\presentation\bloc\popular_tv_series_event_state.dart" "lib\tv_series\presentation\bloc\popular_tv_series_event_state.dart"
move /Y "lib\presentation\bloc\top_rated_tv_series_bloc.dart" "lib\tv_series\presentation\bloc\top_rated_tv_series_bloc.dart"
move /Y "lib\presentation\bloc\top_rated_tv_series_event_state.dart" "lib\tv_series\presentation\bloc\top_rated_tv_series_event_state.dart"
move /Y "lib\presentation\bloc\tv_series_detail_bloc.dart" "lib\tv_series\presentation\bloc\tv_series_detail_bloc.dart"
move /Y "lib\presentation\bloc\tv_series_detail_event_state.dart" "lib\tv_series\presentation\bloc\tv_series_detail_event_state.dart"
move /Y "lib\presentation\bloc\tv_series_search_bloc.dart" "lib\tv_series\presentation\bloc\tv_series_search_bloc.dart"
move /Y "lib\presentation\bloc\tv_series_search_event_state.dart" "lib\tv_series\presentation\bloc\tv_series_search_event_state.dart"
move /Y "lib\presentation\bloc\tv_series_watchlist_bloc.dart" "lib\tv_series\presentation\bloc\tv_series_watchlist_bloc.dart"
move /Y "lib\presentation\bloc\tv_series_watchlist_event_state.dart" "lib\tv_series\presentation\bloc\tv_series_watchlist_event_state.dart"

REM Note: tv_series_list_bloc.dart and tv_series_list_event_state.dart are no longer used (we split them)
REM Delete them if they still exist
del "lib\presentation\bloc\tv_series_list_bloc.dart" 2>nul
del "lib\presentation\bloc\tv_series_list_event_state.dart" 2>nul

move /Y "lib\presentation\widgets\tv_series_card.dart" "lib\tv_series\presentation\widgets\tv_series_card.dart"
echo ✓ TV Series presentation moved

echo.
echo [Cleanup] Removing empty folders...
rmdir "lib\domain\entities" 2>nul
rmdir "lib\domain\repositories" 2>nul
rmdir "lib\domain\usecases" 2>nul
rmdir "lib\domain" 2>nul
rmdir "lib\data\models" 2>nul
rmdir "lib\data\datasources" 2>nul
rmdir "lib\data\repositories" 2>nul
rmdir "lib\data" 2>nul
rmdir "lib\presentation\pages" 2>nul
rmdir "lib\presentation\provider" 2>nul
rmdir "lib\presentation\widgets" 2>nul
rmdir "lib\presentation\bloc" 2>nul
rmdir "lib\presentation" 2>nul
echo ✓ Empty folders removed

echo.
echo ========================================
echo ✅ PHASE 4 COMPLETE!
echo ========================================
echo.
echo Next: Files need import path updates!
echo Notify me to continue...
echo.
pause
