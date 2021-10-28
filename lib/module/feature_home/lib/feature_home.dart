import 'package:core/core.dart';
import 'package:libraries/libraries.dart';
import 'presentation/pages/bottom_nav_page.dart';

class FeatureHome extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          MainRoutes.home,
          child: (_, __) => const BottomNavPage(),
        ),
      ];
}
