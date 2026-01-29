import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/movie/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/movie/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/movie/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/movie/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/movie/domain/usecases/save_watchlist.dart';
import 'package:ditonton/movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/movie/presentation/bloc/movie_detail/movie_detail_event.dart';
import 'package:ditonton/movie/presentation/bloc/movie_detail/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
    );
    movieRecommendationsBloc = MovieRecommendationsBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
    movieWatchlistBloc = MovieWatchlistBloc(
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group('MovieDetailBloc', () {
    test('initial state should be empty', () {
      expect(movieDetailBloc.state, MovieDetailEmpty());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Loaded] when movie detail is fetched successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailLoaded(testMovieDetail),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Error] when movie detail fetch fails',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailError('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Error] when database failure occurs',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(DatabaseFailure('Database Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailError('Database Failure'),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('MovieRecommendationsBloc', () {
    test('initial state should be empty', () {
      expect(movieRecommendationsBloc.state, MovieRecommendationsEmpty());
    });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'should emit [Loading, Loaded] when recommendations are fetched successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MovieRecommendationsLoading(),
        MovieRecommendationsLoaded(testMovieList),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'should emit [Loading, Error] when recommendations fetch fails',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MovieRecommendationsLoading(),
        const MovieRecommendationsError('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
      'should emit [Loading, Empty] when recommendations list is empty',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Right([]));
        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => [
        MovieRecommendationsLoading(),
        const MovieRecommendationsLoaded([]),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('MovieWatchlistBloc', () {
    test('initial state should be WatchlistStatus with false', () {
      expect(movieWatchlistBloc.state, const WatchlistStatus(false));
    });

    blocTest<MovieWatchlistBloc, WatchlistStatus>(
      'should emit [true] when LoadWatchlistStatus is added and movie is in watchlist',
      build: () {
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => true);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
      expect: () => [
        const WatchlistStatus(true),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistStatus>(
      'should emit [false] when LoadWatchlistStatus is added and movie is not in watchlist',
      build: () {
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
      expect: () => [
        const WatchlistStatus(false),
      ],
      verify: (_) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistStatus>(
      'should emit [true] when AddToWatchlist is successful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddToWatchlist(testMovieDetail)),
      expect: () => [
        const WatchlistStatus(true),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistStatus>(
      'should emit [false] when AddToWatchlist fails',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed to add')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const AddToWatchlist(testMovieDetail)),
      expect: () => [
        const WatchlistStatus(false),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistStatus>(
      'should emit [false] when RemoveFromWatchlist is successful',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        const WatchlistStatus(false),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, WatchlistStatus>(
      'should emit [true] when RemoveFromWatchlist fails',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed to remove')));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        const WatchlistStatus(true),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });
}
