import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:innerverse/l10n/l10n.dart';
import 'package:innerverse/navigation/routes.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();
// apk dedio raat tak
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
    ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
