import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:namer_app/utils/accessibility/accessibility.dart';

class SettingsPage extends ConsumerWidget {
  static const routeName = "settings";
  static const fullPath = "/$routeName";

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.text_language),
              DropdownButton(
                key: const Key(Accessibility.dropdownLanguage),
                value: Locale(l10n.localeName),
                items: AppLocalizations.supportedLocales.map<DropdownMenuItem<Locale>>((Locale value) {
                  return DropdownMenuItem<Locale>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (locale) => {
                  ref.read(localeProvider.notifier).setLocale(locale!),
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
