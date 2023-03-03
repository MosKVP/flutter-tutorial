import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/modules/main/pages/favorites_page.dart';
import 'package:namer_app/modules/main/pages/generator_page.dart';
import 'package:namer_app/modules/main/main_module.dart';
import 'package:namer_app/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:namer_app/modules/main/pages/settings_page.dart';

void main() {
  final container = ProviderContainer();
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModularApp(
      module: AppModule(),
      child: MaterialApp.router(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        locale: ref.watch(localeProvider),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}