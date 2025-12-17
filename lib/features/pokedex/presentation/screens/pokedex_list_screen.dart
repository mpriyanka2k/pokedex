import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/themes/theme_notifier.dart';
import 'package:pokedex/features/auth/presentation/riverpod/auth_notifire.dart';
import 'package:pokedex/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedex/pokedex_notifire.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedex/pokedex_provider.dart';
import 'package:pokedex/l10n/app_local_notifire.dart';
import 'package:pokedex/l10n/app_localizations.dart';

class PokedexListScreen extends ConsumerWidget {
  const PokedexListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);
    final pokedexNotifire = ref.read(pokedexProvider.notifier);
    final pokedexState = ref.watch(pokedexProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,

      /// ---------- APP BAR ----------
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.pokedex,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showLanguageChangeDialog(context);
            },
            icon: Icon(Icons.language),
          ),
          IconButton(
            onPressed: () {
              _showThemeChangeDialog(context);
            },
            icon: Icon(Icons.color_lens),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context, authNotifier,pokedexNotifire),
          ),
        ],
      ),

      /// ---------- BODY ----------
      body: Builder(
        builder: (context) {
          if (pokedexState.loading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (pokedexState.error != null) {
            return _ErrorView(message: pokedexState.error!);
          }

          if (pokedexState.data == null || pokedexState.data!.isEmpty) {
            return const _EmptyView();
          }

          final pokemonList = pokedexState.data!;

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: pokemonList.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (ctx, index) {
              final pokemon = pokemonList[index];

              return InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  context.push('/pokedex_detail/${index + 1}');
                },
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      /// Index Badge
                      Container(
                        height: 44.w,
                        width: 44.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${index + 1}",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),

                      /// Name & URL
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pokemon.name.toUpperCase(),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              pokemon.url,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.hintColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      Icon(Icons.chevron_right, color: theme.iconTheme.color),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /// ---------- LOGOUT DIALOG ----------
  void _showLogoutDialog(BuildContext context, AuthNotifier authNotifier,PokedexNotifier pokedexNotifire) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          AppLocalizations.of(context)!.logout,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content:  Text(AppLocalizations.of(context)!.logoutWarning,),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(AppLocalizations.of(context)!.cancel, style: TextStyle(color: colorScheme.error)),
          ),
          ElevatedButton(
            onPressed: () {
              authNotifier.logout().then((_) {
              
                context.pop();
                context.go('/login');
                pokedexNotifire.clearHiveDatabase();
              });
            },
            child:  Text(AppLocalizations.of(context)!.logout),
          ),
        ],
      ),
    );
  }

  void _showThemeChangeDialog(
    BuildContext context,
  ) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          AppLocalizations.of(context)!.changeTheme,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Consumer(
          builder: (context, ref, _) {
            final mode = ref.watch(themeNotifierProvider);
            final themeController = ref.read(themeNotifierProvider.notifier);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  title:  Text(AppLocalizations.of(context)!.systemDefault,),
                  value: ThemeMode.system,
                  groupValue: mode,
                  onChanged: (_) {
                    themeController.setSystem();
                    context.pop();
                  },
                ),
                RadioListTile<ThemeMode>(
                  title:  Text(AppLocalizations.of(context)!.light,),
                  value: ThemeMode.light,
                  groupValue: mode,
                  onChanged: (_) {
                    themeController.setLight();
                    context.pop();
                  },
                ),
                RadioListTile<ThemeMode>(
                  title:  Text(AppLocalizations.of(context)!.dark,),
                  value: ThemeMode.dark,
                  groupValue: mode,
                  onChanged: (_) {
                    themeController.setDark();
                    context.pop();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showLanguageChangeDialog(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          AppLocalizations.of(context)!.changeLanguage,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Consumer(
          builder: (context, ref, _) {
            final selectedLocale = ref.watch(appLocalNotifireProvider);
            final appLocaleController = ref.read(appLocalNotifireProvider.notifier);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<AppLocale>(
                  title: Text(AppLocale.english.label),
                  value: AppLocale.english,
                  groupValue: selectedLocale,
                  onChanged: (value) {
                    appLocaleController.english();
                    context.pop();
                  },
                ),
                RadioListTile<AppLocale>(
                  title: Text(AppLocale.hindi.label),
                  value: AppLocale.hindi,
                  groupValue: selectedLocale,
                  onChanged: (value) {
                    appLocaleController.hindi();
                    context.pop();
                  },
                ),

                RadioListTile<AppLocale>(
                  title: Text(AppLocale.spanish.label),
                  value: AppLocale.spanish,
                  groupValue: selectedLocale,
                  onChanged: (value) {
                   appLocaleController.spanish();
                    context.pop();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// ---------- EMPTY STATE ----------
class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.noPokemonFound,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

/// ---------- ERROR STATE ----------
class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
