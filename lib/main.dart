import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/core/di/injection.dart';
import 'package:pokedex/core/hive/hive_services.dart';
import 'package:pokedex/core/router/app_router.dart';
import 'package:pokedex/core/theme/app_theme.dart';
import 'package:pokedex/core/themes/theme_notifier.dart';
import 'package:pokedex/l10n/app_local_notifire.dart';
import 'package:pokedex/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await init(); 
    await locator<HiveService>().init();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    // read the notifier to access themeMode
    final themeMode = ref.watch(themeNotifierProvider);

    final appLocale = ref.watch(appLocalNotifireProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: appLocale.locale,
          localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,],
              supportedLocales: [
                Locale('en'),
                Locale('es'),
                Locale('hi')
              ],
           title: "Pokedex",
           theme: AppTheme.lightTheme,
           darkTheme: AppTheme.darkTheme,
           themeMode: themeMode,
           routerConfig: router,
        );
      }
    );  
  }
}