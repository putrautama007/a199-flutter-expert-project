// Mocks generated by Mockito 5.0.16 from annotations
// in feature_movie/test/presentation/bloc/watch_list/watch_list_movie_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/core.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:feature_movie/domain/entities/movie.dart' as _i6;
import 'package:feature_movie/domain/usecases/get_watchlist_movies.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends _i1.Mock
    implements _i3.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Movie>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  String toString() => super.toString();
}
