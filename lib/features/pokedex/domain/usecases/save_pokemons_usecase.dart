import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';
import 'package:pokedex/features/pokedex/domain/repository/pokedex_repo.dart';

class SavePokemonsUsecase {
  final PokedexRepo pokedexRepo;
  SavePokemonsUsecase(this.pokedexRepo);

  void savePokemons(List<PokemonEntity> pokemons){
    pokedexRepo.savePokemons(pokemons);
  }
  
}