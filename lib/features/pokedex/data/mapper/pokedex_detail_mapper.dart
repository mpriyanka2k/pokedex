import 'package:pokedex/features/pokedex/data/model/pokemon_detail_model.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokemon_detail_entity.dart';

class PokedexDetailMapper {
  static PokemonDetailEntity toPokemonEntity(PokemonDetail model) {
    return PokemonDetailEntity(
      name: model.name,
      img: model.sprites.backDefault,
    );
  }
}
