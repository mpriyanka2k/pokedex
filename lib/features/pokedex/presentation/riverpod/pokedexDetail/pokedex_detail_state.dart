
import 'package:pokedex/features/pokedex/domain/entity/pokemon_detail_entity.dart';

class PokedexDetailState {
  final bool loading;
  final PokemonDetailEntity? data;
  final String? error;

  PokedexDetailState({this.loading = false, this.data, this.error});
}