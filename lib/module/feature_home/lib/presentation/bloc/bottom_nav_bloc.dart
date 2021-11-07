import 'package:feature_home/presentation/bloc/bottom_nav_event.dart';
import 'package:libraries/libraries.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, int> {
  BottomNavBloc({
    required int initialState,
  }) : super(initialState);

  @override
  Stream<int> mapEventToState(BottomNavEvent event) async* {
    if (event is ChangeTabEvent) {
      yield event.state;
    }
  }
}
