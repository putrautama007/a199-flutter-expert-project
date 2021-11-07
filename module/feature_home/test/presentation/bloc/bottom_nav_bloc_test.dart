import 'package:bloc_test/bloc_test.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_bloc.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BottomNavBloc bottomNavBloc;

  setUp(() {
    bottomNavBloc = BottomNavBloc(initialState: 0);
  });

  blocTest<BottomNavBloc, int>(
    'Should emit [] when call nothing',
    build: () {
      return bottomNavBloc;
    },
    expect: () => [],
  );

  blocTest<BottomNavBloc, int>(
    'Should emit [0] when call ChangeTabEvent with 0 index tab',
    build: () {
      return bottomNavBloc;
    },
    act: (bloc) => bloc.add(ChangeTabEvent(state: 0)),
    expect: () => [0],
  );

  blocTest<BottomNavBloc, int>(
    'Should emit [1] when call ChangeTabEvent with 1 index tab',
    build: () {
      return bottomNavBloc;
    },
    act: (bloc) => bloc.add(ChangeTabEvent(state: 1)),
    expect: () => [1],
  );

  blocTest<BottomNavBloc, int>(
    'Should emit [2] when call ChangeTabEvent with 2 index tab',
    build: () {
      return bottomNavBloc;
    },
    act: (bloc) => bloc.add(ChangeTabEvent(state: 2)),
    expect: () => [2],
  );

  blocTest<BottomNavBloc, int>(
    'Should emit [3] when call ChangeTabEvent with 3 index tab',
    build: () {
      return bottomNavBloc;
    },
    act: (bloc) => bloc.add(ChangeTabEvent(state: 3)),
    expect: () => [3],
  );
}
