import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:namer_app/main.dart' as app;
import 'package:namer_app/modules/main/pages/generator_page.dart';
import 'package:namer_app/utils/accessibility/accessibility.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  group('end-to-end test', () {
    final buttonLike = find.byKey(const Key(Accessibility.buttonLike));
    final buttonNext = find.byKey(const Key(Accessibility.buttonNext));
    final navItemHome = find.byKey(const Key(Accessibility.navItemHome));
    final navItemFavorites = find.byKey(const Key(Accessibility.navItemFavorites));
    final fab = find.byType(FloatingActionButton);
    testWidgets('user can tap like once to add a wordPair to favorites, tap again to remove from favorites',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(buttonLike, findsOneWidget);
      expect(buttonNext, findsOneWidget);
      expect(navItemHome, findsOneWidget);
      expect(navItemFavorites, findsOneWidget);

      await tap(tester, navItemFavorites);
      expect(find.text("No favorites yet."), findsOneWidget);

      await tap(tester, navItemHome);
      await tap(tester, buttonLike);
      await tap(tester, navItemFavorites);
      expect(find.text("You have 1 favorites:"), findsOneWidget);

      await tap(tester, navItemHome);
      await tap(tester, buttonLike);
      await tap(tester, navItemFavorites);
      expect(find.text("No favorites yet."), findsOneWidget);
    });

    testWidgets('user can tap next to get a new wordPair', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final bigCard = find.byType(BigCard);
      WordPair previousWordPair = tester.widget<BigCard>(bigCard).pair;
      await tap(tester, buttonNext);
      expect(tester.widget<BigCard>(bigCard).pair, isNot(previousWordPair));

      previousWordPair = tester.widget<BigCard>(bigCard).pair;
      await tap(tester, buttonNext);
      expect(tester.widget<BigCard>(bigCard).pair, isNot(previousWordPair));

      previousWordPair = tester.widget<BigCard>(bigCard).pair;
      await tap(tester, buttonNext);
      expect(tester.widget<BigCard>(bigCard).pair, isNot(previousWordPair));
    });

    testWidgets('user can like multiple wordPairs and see them in favorites', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tap(tester, navItemFavorites);
      expect(find.text("No favorites yet."), findsOneWidget);

      await tap(tester, navItemHome);
      await tap(tester, buttonLike);
      await tap(tester, navItemFavorites);
      expect(find.text("You have 1 favorites:"), findsOneWidget);

      await tap(tester, navItemHome);
      await tap(tester, buttonNext);
      await tap(tester, buttonLike);
      await tap(tester, navItemFavorites);
      expect(find.text("You have 2 favorites:"), findsOneWidget);

      await tap(tester, navItemHome);
      await tap(tester, buttonNext);
      await tap(tester, buttonLike);
      await tap(tester, navItemFavorites);
      expect(find.text("You have 3 favorites:"), findsOneWidget);
    });

    testWidgets('user can change the language in the settings page', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text("Like"), findsOneWidget);
      expect(find.text("ถูกใจ"), findsNothing);
      expect(find.text("Next"), findsOneWidget);
      expect(find.text("ต่อไป"), findsNothing);

      await tap(tester, fab);
      expect(find.text("Settings"), findsOneWidget);
      expect(find.text("Language"), findsOneWidget);
      expect(find.text("ภาษา"), findsNothing);

      final dropdownLanguage = find.byKey(const Key(Accessibility.dropdownLanguage));

      expect(tester.firstWidget<DropdownButton>(dropdownLanguage).items?.length, 2);
      await tap(tester, dropdownLanguage);

      expect(find.widgetWithText(DropdownMenuItem<Locale>, "en"), findsNWidgets(2));
      expect(find.widgetWithText(DropdownMenuItem<Locale>, "th"), findsNWidgets(2));

      await tap(tester, find.text("th").last);
      expect(find.text("Language"), findsNothing);
      expect(find.text("ภาษา"), findsOneWidget);

      await tap(tester, find.byType(BackButton));
      expect(find.text("Like"), findsNothing);
      expect(find.text("ถูกใจ"), findsOneWidget);
      expect(find.text("Next"), findsNothing);
      expect(find.text("ต่อไป"), findsOneWidget);
    });
  });
}
