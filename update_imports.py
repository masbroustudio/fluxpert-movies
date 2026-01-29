#!/usr/bin/env python3
"""
Mass Import Path Updater for Modularization
Updates all import paths from old structure to new modular structure
"""

import os
import re
from pathlib import Path

# Base directory
BASE_DIR = Path(__file__).parent / "lib"

# Import mapping rules
IMPORT_MAPPINGS = {
    # Core mappings
    r"package:ditonton/common/": "package:ditonton/core/common/",
    r"package:ditonton/data/datasources/db/": "package:ditonton/core/database/",
    r"package:ditonton/injection\.dart": "package:ditonton/core/di/injection.dart",
    
    # Genre (shared entity) - now in core
    r"package:ditonton/domain/entities/genre\.dart": "package:ditonton/core/common/genre.dart",
    r"package:ditonton/data/models/genre_model\.dart": "package:ditonton/core/common/genre_model.dart",
    
    # About page - now in core
    r"package:ditonton/presentation/pages/about_page\.dart": "package:ditonton/core/common/about_page.dart",
    
    # Movie module mappings
    r"package:ditonton/domain/entities/movie\.dart": "package:ditonton/movie/domain/entities/movie.dart",
    r"package:ditonton/domain/entities/movie_detail\.dart": "package:ditonton/movie/domain/entities/movie_detail.dart",
    r"package:ditonton/domain/repositories/movie_repository\.dart": "package:ditonton/movie/domain/repositories/movie_repository.dart",
    r"package:ditonton/domain/usecases/get_movie_detail\.dart": "package:ditonton/movie/domain/usecases/get_movie_detail.dart",
    r"package:ditonton/domain/usecases/get_movie_recommendations\.dart": "package:ditonton/movie/domain/usecases/get_movie_recommendations.dart",
    r"package:ditonton/domain/usecases/get_now_playing_movies\.dart": "package:ditonton/movie/domain/usecases/get_now_playing_movies.dart",
    r"package:ditonton/domain/usecases/get_popular_movies\.dart": "package:ditonton/movie/domain/usecases/get_popular_movies.dart",
    r"package:ditonton/domain/usecases/get_top_rated_movies\.dart": "package:ditonton/movie/domain/usecases/get_top_rated_movies.dart",
    r"package:ditonton/domain/usecases/get_watchlist_movies\.dart": "package:ditonton/movie/domain/usecases/get_watchlist_movies.dart",
    r"package:ditonton/domain/usecases/get_watchlist_status\.dart": "package:ditonton/movie/domain/usecases/get_watchlist_status.dart",
    r"package:ditonton/domain/usecases/remove_watchlist\.dart": "package:ditonton/movie/domain/usecases/remove_watchlist.dart",
    r"package:ditonton/domain/usecases/save_watchlist\.dart": "package:ditonton/movie/domain/usecases/save_watchlist.dart",
    r"package:ditonton/domain/usecases/search_movies\.dart": "package:ditonton/movie/domain/usecases/search_movies.dart",
    
    r"package:ditonton/data/models/movie_model\.dart": "package:ditonton/movie/data/models/movie_model.dart",
    r"package:ditonton/data/models/movie_detail_model\.dart": "package:ditonton/movie/data/models/movie_detail_model.dart",
    r"package:ditonton/data/models/movie_response\.dart": "package:ditonton/movie/data/models/movie_response.dart",
    r"package:ditonton/data/models/movie_table\.dart": "package:ditonton/movie/data/models/movie_table.dart",
    
    r"package:ditonton/data/datasources/movie_local_data_source\.dart": "package:ditonton/movie/data/datasources/movie_local_data_source.dart",
    r"package:ditonton/data/datasources/movie_remote_data_source\.dart": "package:ditonton/movie/data/datasources/movie_remote_data_source.dart",
    
    r"package:ditonton/data/repositories/movie_repository_impl\.dart": "package:ditonton/movie/data/repositories/movie_repository_impl.dart",
    
    r"package:ditonton/presentation/pages/home_movie_page\.dart": "package:ditonton/movie/presentation/pages/home_movie_page.dart",
    r"package:ditonton/presentation/pages/movie_detail_page\.dart": "package:ditonton/movie/presentation/pages/movie_detail_page.dart",
    r"package:ditonton/presentation/pages/popular_movies_page\.dart": "package:ditonton/movie/presentation/pages/popular_movies_page.dart",
    r"package:ditonton/presentation/pages/top_rated_movies_page\.dart": "package:ditonton/movie/presentation/pages/top_rated_movies_page.dart",
    r"package:ditonton/presentation/pages/search_page\.dart": "package:ditonton/movie/presentation/pages/search_page.dart",
    r"package:ditonton/presentation/pages/watchlist_movies_page\.dart": "package:ditonton/movie/presentation/pages/watchlist_movies_page.dart",
    
    r"package:ditonton/presentation/provider/movie_detail_notifier\.dart": "package:ditonton/movie/presentation/provider/movie_detail_notifier.dart",
    r"package:ditonton/presentation/provider/movie_list_notifier\.dart": "package:ditonton/movie/presentation/provider/movie_list_notifier.dart",
    r"package:ditonton/presentation/provider/movie_search_notifier\.dart": "package:ditonton/movie/presentation/provider/movie_search_notifier.dart",
    r"package:ditonton/presentation/provider/popular_movies_notifier\.dart": "package:ditonton/movie/presentation/provider/popular_movies_notifier.dart",
    r"package:ditonton/presentation/provider/top_rated_movies_notifier\.dart": "package:ditonton/movie/presentation/provider/top_rated_movies_notifier.dart",
    r"package:ditonton/presentation/provider/watchlist_movie_notifier\.dart": "package:ditonton/movie/presentation/provider/watchlist_movie_notifier.dart",
    
    r"package:ditonton/presentation/widgets/movie_card_list\.dart": "package:ditonton/movie/presentation/widgets/movie_card_list.dart",
    
    # TV Series module mappings
    r"package:ditonton/domain/entities/tv_series\.dart": "package:ditonton/tv_series/domain/entities/tv_series.dart",
    r"package:ditonton/domain/entities/tv_series_detail\.dart": "package:ditonton/tv_series/domain/entities/tv_series_detail.dart",
    r"package:ditonton/domain/repositories/tv_series_repository\.dart": "package:ditonton/tv_series/domain/repositories/tv_series_repository.dart",
    
    r"package:ditonton/domain/usecases/get_on_the_air_tv_series\.dart": "package:ditonton/tv_series/domain/usecases/get_on_the_air_tv_series.dart",
    r"package:ditonton/domain/usecases/get_popular_tv_series\.dart": "package:ditonton/tv_series/domain/usecases/get_popular_tv_series.dart",
    r"package:ditonton/domain/usecases/get_top_rated_tv_series\.dart": "package:ditonton/tv_series/domain/usecases/get_top_rated_tv_series.dart",
    r"package:ditonton/domain/usecases/get_tv_series_detail\.dart": "package:ditonton/tv_series/domain/usecases/get_tv_series_detail.dart",
    r"package:ditonton/domain/usecases/get_tv_series_recommendations\.dart": "package:ditonton/tv_series/domain/usecases/get_tv_series_recommendations.dart",
    r"package:ditonton/domain/usecases/get_watchlist_tv_series\.dart": "package:ditonton/tv_series/domain/usecases/get_watchlist_tv_series.dart",
    r"package:ditonton/domain/usecases/get_watchlist_tv_series_status\.dart": "package:ditonton/tv_series/domain/usecases/get_watchlist_tv_series_status.dart",
    r"package:ditonton/domain/usecases/remove_tv_series_watchlist\.dart": "package:ditonton/tv_series/domain/usecases/remove_tv_series_watchlist.dart",
    r"package:ditonton/domain/usecases/save_tv_series_watchlist\.dart": "package:ditonton/tv_series/domain/usecases/save_tv_series_watchlist.dart",
    r"package:ditonton/domain/usecases/search_tv_series\.dart": "package:ditonton/tv_series/domain/usecases/search_tv_series.dart",
    
    r"package:ditonton/data/models/tv_series_model\.dart": "package:ditonton/tv_series/data/models/tv_series_model.dart",
    r"package:ditonton/data/models/tv_series_detail_model\.dart": "package:ditonton/tv_series/data/models/tv_series_detail_model.dart",
    r"package:ditonton/data/models/tv_series_response\.dart": "package:ditonton/tv_series/data/models/tv_series_response.dart",
    r"package:ditonton/data/models/tv_series_table\.dart": "package:ditonton/tv_series/data/models/tv_series_table.dart",
    
    r"package:ditonton/data/datasources/tv_series_local_data_source\.dart": "package:ditonton/tv_series/data/datasources/tv_series_local_data_source.dart",
    r"package:ditonton/data/datasources/tv_series_remote_data_source\.dart": "package:ditonton/tv_series/data/datasources/tv_series_remote_data_source.dart",
    
    r"package:ditonton/data/repositories/tv_series_repository_impl\.dart": "package:ditonton/tv_series/data/repositories/tv_series_repository_impl.dart",
    
    r"package:ditonton/presentation/pages/home_tv_series_page\.dart": "package:ditonton/tv_series/presentation/pages/home_tv_series_page.dart",
    r"package:ditonton/presentation/pages/tv_series_detail_page\.dart": "package:ditonton/tv_series/presentation/pages/tv_series_detail_page.dart",
    r"package:ditonton/presentation/pages/popular_tv_series_page\.dart": "package:ditonton/tv_series/presentation/pages/popular_tv_series_page.dart",
    r"package:ditonton/presentation/pages/top_rated_tv_series_page\.dart": "package:ditonton/tv_series/presentation/pages/top_rated_tv_series_page.dart",
    r"package:ditonton/presentation/pages/on_the_air_tv_series_page\.dart": "package:ditonton/tv_series/presentation/pages/on_the_air_tv_series_page.dart",
    r"package:ditonton/presentation/pages/search_tv_series_page\.dart": "package:ditonton/tv_series/presentation/pages/search_tv_series_page.dart",
    r"package:ditonton/presentation/pages/watchlist_tv_series_page\.dart": "package:ditonton/tv_series/presentation/pages/watchlist_tv_series_page.dart",
    
    r"package:ditonton/presentation/bloc/on_the_air_tv_series_bloc\.dart": "package:ditonton/tv_series/presentation/bloc/on_the_air_tv_series_bloc.dart",
    r"package:ditonton/presentation/bloc/on_the_air_tv_series_event_state\.dart": "package:ditonton/tv_series/presentation/bloc/on_the_air_tv_series_event_state.dart",
    r"package:ditonton/presentation/bloc/popular_tv_series_bloc\.dart": "package:ditonton/tv_series/presentation/bloc/popular_tv_series_bloc.dart",
    r"package:ditonton/presentation/bloc/popular_tv_series_event_state\.dart": "package:ditonton/tv_series/presentation/bloc/popular_tv_series_event_state.dart",
    r"package:ditonton/presentation/bloc/top_rated_tv_series_bloc\.dart": "package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_bloc.dart",
    r"package:ditonton/presentation/bloc/top_rated_tv_series_event_state\.dart": "package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_event_state.dart",
    r"package:ditonton/presentation/bloc/tv_series_detail_bloc\.dart": "package:ditonton/tv_series/presentation/bloc/tv_series_detail_bloc.dart",
    r"package:ditonton/presentation/bloc/tv_series_detail_event_state\.dart": "package:ditonton/tv_series/presentation/bloc/tv_series_detail_event_state.dart",
    r"package:ditonton/presentation/bloc/tv_series_search_bloc\.dart": "package:ditonton/tv_series/presentation/bloc/tv_series_search_bloc.dart",
    r"package:ditonton/presentation/bloc/tv_series_search_event_state\.dart": "package:ditonton/tv_series/presentation/bloc/tv_series_search_event_state.dart",
    r"package:ditonton/presentation/bloc/tv_series_watchlist_bloc\.dart": "package:ditonton/tv_series/presentation/bloc/tv_series_watchlist_bloc.dart",
    r"package:ditonton/presentation/bloc/tv_series_watchlist_event_state\.dart": "package:ditonton/tv_series/presentation/bloc/tv_series_watchlist_event_state.dart",
    
    r"package:ditonton/presentation/widgets/tv_series_card\.dart": "package:ditonton/tv_series/presentation/widgets/tv_series_card.dart",
}

def update_imports_in_file(file_path):
    """Update import paths in a single file"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        modified = False
        
        # Apply all mappings
        for old_pattern, new_path in IMPORT_MAPPINGS.items():
            if re.search(old_pattern, content):
                content = re.sub(old_pattern, new_path, content)
                modified = True
        
        # Write back if modified
        if modified:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False
    
    except Exception as e:
        print(f"Error processing {file_path}: {e}")
        return False

def main():
    print("=" * 60)
    print("MASS IMPORT PATH UPDATER")
    print("=" * 60)
    print()
    
    # Find all Dart files
    dart_files = list(BASE_DIR.rglob("*.dart"))
    
    print(f"Found {len(dart_files)} Dart files to process")
    print()
    
    updated_count = 0
    for dart_file in dart_files:
        relative_path = dart_file.relative_to(BASE_DIR)
        if update_imports_in_file(dart_file):
            print(f"✓ Updated: {relative_path}")
            updated_count += 1
        else:
            # Only show if in verbose mode
            pass
    
    print()
    print("=" * 60)
    print(f"✅ COMPLETE! Updated {updated_count} files")
    print("=" * 60)
    print()
    print("Next: Update test files with 'python update_test_imports.py'")

if __name__ == "__main__":
    main()
