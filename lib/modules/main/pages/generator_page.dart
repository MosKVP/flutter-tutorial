import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:namer_app/provider.dart';
import 'package:namer_app/utils/accessibility/accessibility.dart';

class GeneratorPage extends ConsumerWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordPair = ref.watch(wordPairProvider);
    final favorites = ref.watch(favoritesProvider);
    final l10n = AppLocalizations.of(context);

    IconData icon;
    if (favorites.contains(wordPair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: wordPair),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                key: const Key(Accessibility.buttonLike),
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite();
                },
                icon: Icon(icon),
                label: Text(l10n.button_like),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                key: const Key(Accessibility.buttonNext),
                onPressed: () {
                  ref.read(wordPairProvider.notifier).getNext();
                },
                child: Text(l10n.button_next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}
