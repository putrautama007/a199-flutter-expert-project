// Mocks generated by Mockito 5.0.16 from annotations
// in ditonton/test/feature/feature_tv/presentation/provider/tv_show_watchlist_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/core/util/common/failure.dart' as _i5;
import 'package:ditonton/feature/feature_tv/domain/entities/tv_entities.dart'
    as _i6;
import 'package:ditonton/feature/feature_tv/domain/usecases/get_watchlist_tv_shows_use_case.dart'
    as _i3;
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

/// A class which mocks [GetWatchListTvShowsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTvShowsUseCase extends _i1.Mock
    implements _i3.GetWatchListTvShowsUseCase {
  MockGetWatchListTvShowsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvEntities>>>
      getWatchlistTvShows() => (super.noSuchMethod(
              Invocation.method(#getWatchlistTvShows, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.TvEntities>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.TvEntities>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.TvEntities>>>);
}
