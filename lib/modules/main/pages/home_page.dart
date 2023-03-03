import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:namer_app/modules/main/pages/favorites_page.dart';
import 'package:namer_app/modules/main/pages/generator_page.dart';
import 'package:namer_app/modules/main/pages/settings_page.dart';
import 'package:namer_app/utils/accessibility/accessibility.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const GeneratorPage();
        break;
      case 1:
        page = const FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              key: Key(Accessibility.navItemHome),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              key: Key(Accessibility.navItemFavorites),
            ),
            label: 'Favorites',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Modular.to.pushNamed(SettingsPage.routeName)},
        shape: const CircleBorder(),
        backgroundColor: theme.colorScheme.primary,
        child: Icon(
          Icons.settings,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
