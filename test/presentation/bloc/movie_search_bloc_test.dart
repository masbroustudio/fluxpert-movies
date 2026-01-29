import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/movie/domain/usecases/search_movies.dart';
import 'package:ditonton/movie/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:ditonton/movie/presentation/bloc/movie_search/movie_search_event.dart';
import 'package:ditonton/movie/presentation/bloc/movie_search/movie_search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(searchMovies: mockSearchMovies);
  });

  const tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(movieSearchBloc.state, MovieSearchEmpty());
  });

  group('Search Movies', () {
    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Loading, Loaded] when search is successful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(testMovieList));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 600), // Wait for debounce
      expect: () => [
        MovieSearchLoading(),
        MovieSearchLoaded(testMovieList),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Loading, Loaded] with empty list when no results found',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => const Right([]));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 600), // Wait for debounce
      expect: () => [
        MovieSearchLoading(),
        const MovieSearchLoaded([]),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Loading, Error] when search fails',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 600), // Wait for debounce
      expect: () => [
        MovieSearchLoading(),
        const MovieSearchError('Server Failure'),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Empty] when ClearSearch is added',
      build: () => movieSearchBloc,
      seed: () => MovieSearchLoaded(testMovieList),
      act: (bloc) => bloc.add(ClearSearch()),
      expect: () => [
        MovieSearchEmpty(),
      ],
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should debounce search events within 500ms',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(testMovieList));
        return movieSearchBloc;
      },
      act: (bloc) async {
        bloc.add(const OnQueryChanged('s'));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(const OnQueryChanged('sp'));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(const OnQueryChanged('spi'));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(const OnQueryChanged(tQuery)); // Only this should execute
      },
      wait: const Duration(milliseconds: 600),
      expect: () => [
        MovieSearchLoading(),
        MovieSearchLoaded(testMovieList),
      ],
      verify: (_) {
        // Verify that execute was only called once (debounce working)
        verify(mockSearchMovies.execute(tQuery)).called(1);
        verifyNever(mockSearchMovies.execute('s'));
        verifyNever(mockSearchMovies.execute('sp'));
        verifyNever(mockSearchMovies.execute('spi'));
      },
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Loading, Error] when connection failure occurs',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed to connect')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        MovieSearchLoading(),
        const MovieSearchError('Failed to connect'),
      ],
      verify: (_) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'should emit [Empty] when query is empty',
      build: () => movieSearchBloc,
      act: (bloc) => bloc.add(const OnQueryChanged('')),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        MovieSearchEmpty(),
      ],
      verify: (_) {
        verifyNever(mockSearchMovies.execute(any));
      },
    );
  });
}
