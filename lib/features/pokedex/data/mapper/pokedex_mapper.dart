import 'package:pokedex/features/pokedex/data/model/pokedex_model.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';

class PokedexMapper {
  static PokedexEntity toEntity(PokedexModel model) {
    return PokedexEntity(
      count: model.count,
      next: model.next,
      previous: model.previous,
      results: model.results
          .map((result) => toPokemonEntity(result))
          .toList(),
    );
  }

 
  static PokemonEntity toPokemonEntity(Result model) {
    return PokemonEntity(
      name: model.name,
      url: model.url,
    );
  }


  static PokedexModel toModel(PokedexEntity entity) {
    return PokedexModel(
      count: entity.count,
      next: entity.next,
      previous: entity.previous,
      results: entity.results.map((e) => toPokemonModel(e)).toList(),
    );
  }

  static Result toPokemonModel(PokemonEntity entity) {
    return Result(
      name: entity.name,
      url: entity.url,
    );
  }

}
