import 'dart:ui';

import 'package:flutter_riverpod/legacy.dart';

enum AppLocale {
  english('English', 'en'),
  hindi('हिंदी', 'hi'),
  spanish('Española', 'es');

  final String label;
  final String languageCode;

  const AppLocale(this.label, this.languageCode);
}

extension AppLocaleX on AppLocale {
  Locale get locale {
    switch (this) {
      case AppLocale.english:
        return const Locale('en');
      case AppLocale.hindi:
        return const Locale('hi');
      case AppLocale.spanish:
        return const Locale('es');
    }
  }
}

class AppLocalNotifire extends StateNotifier<AppLocale> {
  AppLocalNotifire() : super(AppLocale.english);

  void english() => state = AppLocale.english;
  void hindi() => state = AppLocale.hindi;
  void spanish() => state = AppLocale.spanish;


}

final appLocalNotifireProvider =
    StateNotifierProvider<AppLocalNotifire, AppLocale>(
      (ref) => AppLocalNotifire(),
    );
