import 'package:core/core.dart';
import 'package:feature_home/presentation/bloc/bottom_nav_bloc.dart';
import 'package:libraries/libraries.dart';
import 'presentation/pages/bottom_nav_page.dart';

class FeatureHome extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          MainRoutes.home,
          child: (_, __) => BlocProvider(
            create: (_) => BottomNavBloc(initialState: 0),
            child: const BottomNavPage(),
          ),
        ),
      ];
}
