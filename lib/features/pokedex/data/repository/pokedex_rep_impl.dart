

// import 'package:pokedex/core/network/api_response.dart';
// import 'package:pokedex/features/pokedex/data/datasources/local_data_sources/pokedex_local_datasources.dart';
// import 'package:pokedex/features/pokedex/data/datasources/remote_data_sources/pokedex_remote_datasources.dart';
// import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';
// import 'package:pokedex/features/pokedex/domain/repository/pokedex_repo.dart';

import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/features/pokedex/data/datasources/local_data_sources/pokedex_local_datasources.dart';
import 'package:pokedex/features/pokedex/data/datasources/remote_data_sources/pokedex_remote_datasources.dart';
import 'package:pokedex/features/pokedex/data/model/pokemon_hive_model.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';
import 'package:pokedex/features/pokedex/domain/repository/pokedex_repo.dart';

class PokedexRepImpl implements PokedexRepo{
  PokedexRemoteDatasources remoteDatasources;
  PokedexLocalDatasources localDatasources;
  PokedexRepImpl(this.remoteDatasources,this.localDatasources);

  @override
  Future<ApiResponse> getPokedexList() async{
   final data = await remoteDatasources.getPokedexList();
   return data;
  }
  
  @override
  Future<ApiResponse> pokedexDetail(String id)async {
    final data = await remoteDatasources.pokedexDetail(id);
    return data;
    
  }
  
  @override
  List<PokemonHiveModel> getPokemons() {
    final pokemons = localDatasources.getPokemons();
    return pokemons;
    
  }
  
  @override
  void savePokemons(List<PokemonEntity> pokemons) {
    localDatasources.savePokemons(pokemons);
  }
  
  @override
  void clearHiveDatabase() {
    localDatasources.clearHiveDatabase();
  }
}