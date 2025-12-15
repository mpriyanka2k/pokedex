import 'package:pokedex/features/pokedex/data/model/pokemon_hive_model.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';
import 'package:pokedex/features/pokedex/domain/repository/pokedex_repo.dart';

class GetPokemonListUsecase {
  final PokedexRepo pokedexRepo;
  GetPokemonListUsecase(this.pokedexRepo);
  
  List<PokemonHiveModel> getPokemons(){
    final pokemons = pokedexRepo.getPokemons();
    return pokemons;
  }

}