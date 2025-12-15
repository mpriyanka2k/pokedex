import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';

class PokedexState {
  final bool loading;
  final List<PokemonEntity>? data;
  final String? error;

  PokedexState({this.loading = false, this.data, this.error});
}