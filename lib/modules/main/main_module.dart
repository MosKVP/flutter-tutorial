import 'package:flutter_modular/flutter_modular.dart';
import 'package:namer_app/modules/main/pages/home_page.dart';
import 'package:namer_app/modules/main/pages/settings_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (context, args) => const MyHomePage()),
        ChildRoute('/${SettingsPage.routeName}', child: (context, args) => const SettingsPage()),
      ];
}
