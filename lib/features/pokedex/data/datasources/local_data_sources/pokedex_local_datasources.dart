import 'package:pokedex/core/hive/hive_services.dart';
import 'package:pokedex/features/pokedex/data/model/pokemon_hive_model.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';

class PokedexLocalDatasources {
  HiveService hiveService;
  PokedexLocalDatasources(this.hiveService);

 
  Future<void> savePokemons(List<PokemonEntity> entities) async {
    
     final box = hiveService.box('pokemonBox');
    await box.delete('pokemon_list');
    final models = entities.map((e) => PokemonHiveModel.fromEntity(e)).toList();

    print("savePokemons = $models");

    // save list (replace old list)
    await box.put('pokemon_list', models);
  }


List<PokemonHiveModel> getPokemons() {
  final box = hiveService.box('pokemonBox');

  final list = (box.get('pokemon_list', defaultValue: []) as List)
      .cast<PokemonHiveModel>();

  for (var data in list) {
    print("name = ${data.name}");
    print("url = ${data.url}");
  }

  return list;
}

 Future<void> clearHiveDatabase() async{
  hiveService.clearBox('pokemonBox');
 }

}
