import 'package:libraries/libraries.dart';

abstract class BottomNavEvent extends Equatable {}

class ChangeTabEvent extends BottomNavEvent {
  final int state;

  ChangeTabEvent({
    required this.state,
  });

  @override
  List<Object?> get props => [state];
}
