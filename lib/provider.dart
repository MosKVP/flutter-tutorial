import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final wordPairProvider = StateNotifierProvider<_WordPairNotifier, WordPair>((ref) => _WordPairNotifier());

class _WordPairNotifier extends StateNotifier<WordPair> {
  _WordPairNotifier() : super(WordPair.random());

  void getNext() {
    state = WordPair.random();
  }
}

final favoritesProvider =
    StateNotifierProvider<_FavoritesNotifier, List<WordPair>>((ref) => _FavoritesNotifier(ref: ref));

class _FavoritesNotifier extends StateNotifier<List<WordPair>> {
  Ref ref;
  _FavoritesNotifier({required this.ref}) : super([]);

  void toggleFavorite() {
    final wordPair = ref.read(wordPairProvider);

    if (state.contains(wordPair)) {
      state.remove(wordPair);
      state = [...state];
    } else {
      state = [...state, wordPair];
    }
  }
}

final localeProvider = StateNotifierProvider<_LocaleNotifier, Locale?>((ref) => _LocaleNotifier());

class _LocaleNotifier extends StateNotifier<Locale?> {
  _LocaleNotifier() : super(null);

  void setLocale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;
    state = locale;
  }
}
