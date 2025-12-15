import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedexDetail/pokedex_detail_provider.dart';
import 'package:pokedex/l10n/app_localizations.dart';
class PokedexDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const PokedexDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<PokedexDetailScreen> createState() =>
      _PokedexDetailScreenState();
}

class _PokedexDetailScreenState
    extends ConsumerState<PokedexDetailScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(pokedexDetailProvider.notifier)
          .getPokedexDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pokedexDetailProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.pokemon,),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary,
              ),
            );
          }

          if (state.error != null) {
            return Center(
              child: Text(
                state.error!,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: colorScheme.error),
              ),
            );
          }

          if (state.data == null) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noDataFound,
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          final pokemon = state.data!;

          return Padding(
            padding:  EdgeInsets.all(20.sp),
            child: Column(
              children: [
                /// ---------- IMAGE ----------
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding:  EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Image.network(
                      pokemon.img,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                 SizedBox(height: 30.sp),

                /// ---------- NAME ----------
                Text(
                  pokemon.name.toUpperCase(),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),


                 SizedBox(height: 10.sp),

                /// ---------- INFO CARD ----------
                Container(
                  width: double.infinity,
                  padding:  EdgeInsets.all(20.sp),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.details,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       SizedBox(height: 20.sp),

                      _InfoTile(
                        label:AppLocalizations.of(context)!.name,
                        value: pokemon.name,
                      ),
                       SizedBox(height: 20.sp),

                      _InfoTile(
                        label: AppLocalizations.of(context)!.pokedexID,
                        value: widget.id,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// ---------- INFO TILE ----------
class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
