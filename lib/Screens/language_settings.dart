import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/LocalizationProvider.dart';
import '../generated/l10n/app_localizations.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).changeLanguage),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Consumer<LocalizationProvider>(
        builder: (context, localizationProvider, child) {
          final supportedLanguages = localizationProvider.getSupportedLanguages();
          final currentLanguage = localizationProvider.getCurrentLanguageName();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: supportedLanguages.length,
            itemBuilder: (context, index) {
              final language = supportedLanguages[index];
              final isSelected = language == currentLanguage;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                elevation: isSelected ? 4 : 1,
                child: ListTile(
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.language,
                    color: isSelected ? Colors.green : Colors.grey[600],
                  ),
                  title: Text(
                    language,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? Colors.green : Colors.black87,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.done, color: Colors.green)
                      : null,
                  onTap: () async {
                    if (!isSelected) {
                      await localizationProvider.changeLanguageByName(language);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${AppLocalizations.of(context).language} ${AppLocalizations.of(context).update}',
                            ),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}