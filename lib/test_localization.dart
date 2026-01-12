import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'generated/l10n/app_localizations.dart';
import 'provider/LocalizationProvider.dart';

class TestLocalization extends StatelessWidget {
  const TestLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).selectYourLanguage),
      ),
      body: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
          return Column(
            children: [
              Text('Current Language: ${localizationProvider.getCurrentLanguageName()}'),
              Text(AppLocalizations.of(context).home),
              Text(AppLocalizations.of(context).jobs),
              Text(AppLocalizations.of(context).profile),
              ElevatedButton(
                onPressed: () => localizationProvider.changeLanguage('hi'),
                child: const Text('Switch to Hindi'),
              ),
              ElevatedButton(
                onPressed: () => localizationProvider.changeLanguage('en'),
                child: const Text('Switch to English'),
              ),
            ],
          );
        },
      ),
    );
  }
}