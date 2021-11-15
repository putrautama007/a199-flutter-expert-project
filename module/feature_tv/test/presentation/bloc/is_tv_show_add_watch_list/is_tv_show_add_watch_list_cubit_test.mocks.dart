// Mocks generated by Mockito 5.0.16 from annotations
// in feature_tv/test/presentation/bloc/is_tv_show_add_watch_list/is_tv_show_add_watch_list_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:core/core.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:feature_tv/domain/entities/tv_detail_entities.dart' as _i7;
import 'package:feature_tv/domain/usecases/get_watchlist_status_tv_shows_use_case.dart'
    as _i3;
import 'package:feature_tv/domain/usecases/remove_watchlist_tv_shows_use_case.dart'
    as _i8;
import 'package:feature_tv/domain/usecases/save_watchlist_tv_shows_use_case.dart'
    as _i5;
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

/// A class which mocks [GetWatchListStatusTvShowsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTvShowsUseCase extends _i1.Mock
    implements _i3.GetWatchListStatusTvShowsUseCase {
  MockGetWatchListStatusTvShowsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}

/// A class which mocks [SaveWatchListTvShowsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchListTvShowsUseCase extends _i1.Mock
    implements _i5.SaveWatchListTvShowsUseCase {
  MockSaveWatchListTvShowsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i6.Failure, String>> saveWatchlist(
          _i7.TvDetailEntities? tvShow) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i6.Failure, String>>.value(
                  _FakeEither_0<_i6.Failure, String>()))
          as _i4.Future<_i2.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchListTvShowsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchListTvShowsUseCase extends _i1.Mock
    implements _i8.RemoveWatchListTvShowsUseCase {
  MockRemoveWatchListTvShowsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i6.Failure, String>> removeWatchlist(
          _i7.TvDetailEntities? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
              returnValue: Future<_i2.Either<_i6.Failure, String>>.value(
                  _FakeEither_0<_i6.Failure, String>()))
          as _i4.Future<_i2.Either<_i6.Failure, String>>);
}
