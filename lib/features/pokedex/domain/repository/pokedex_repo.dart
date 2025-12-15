import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/features/pokedex/data/model/pokemon_hive_model.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';

abstract class PokedexRepo {
  Future<ApiResponse> getPokedexList();
  Future<ApiResponse> pokedexDetail(String id);
  List<PokemonHiveModel> getPokemons();
  void savePokemons(List<PokemonEntity> pokemons);
  void clearHiveDatabase();
}