import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/core/network/internet_connectivity_provider.dart';
import 'package:pokedex/core/network/network_info.dart';
import 'package:pokedex/features/pokedex/data/model/pokemon_hive_model.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';
import 'package:pokedex/features/pokedex/domain/usecases/clear_hive_database_usecase.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemon_list_usecase.dart';
import 'package:pokedex/features/pokedex/domain/usecases/pokedex_list_usecases.dart';
import 'package:pokedex/features/pokedex/domain/usecases/save_pokemons_usecase.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedex/pokedex_state.dart';

class PokedexNotifier extends StateNotifier<PokedexState> {
  final PokedexListUsecases pokedexListUsecases;
  final SavePokemonsUsecase savePokemonsUsecase;
  final GetPokemonListUsecase getPokemonListUsecase;
  final ClearHiveDatabaseUsecase clearHiveDatabaseUsecase;
  final NetworkInfo networkInfo;
  final Ref ref;

  PokedexNotifier(
    this.pokedexListUsecases,
    this.savePokemonsUsecase,
    this.getPokemonListUsecase,
    this.clearHiveDatabaseUsecase,
    this.networkInfo,
    this.ref
  ) : super(PokedexState()) {
    // 1️⃣ Load DB first
    getPokemons();

    // 2️⃣ Listen to internet changes
    ref.listen<AsyncValue<InternetStatus>>(
      connectivityProvider,
      (previous, next) {
        print("previous = ${previous?.value}");
        print("next = ${next?.value}");
        next.whenData((status) {
          print("status = $status");
          if (status == InternetStatus.connected) {
            getPokemonListData();
          }
        });
      },
    );
    
  }

  Future<void> getPokemonListData() async {
    state = PokedexState(loading: true);
    try {
      final result = await pokedexListUsecases.getPokedexList();
      if (result is ApiSuccess) {
        print("priyanka result ==== ${result.data}");
        final pokemonList = List<PokemonEntity>.from(result.data);
        savePokemons(pokemonList);
        state = PokedexState(loading: false, data: pokemonList);
      } else if (result is ApiError) {
        state = PokedexState(error: result.message);
      }
    } catch (e) {
      print("e = $e");
      state = PokedexState(error: e.toString(), loading: false);
    }
  }

  void savePokemons(List<PokemonEntity> pokemons) {
    try {
      savePokemonsUsecase.savePokemons(pokemons);
    } catch (e) {
      print("error $e");
    }
  }

  void getPokemons() {
    state = PokedexState(loading: true);
    try {
      final List<PokemonHiveModel> pokemons = getPokemonListUsecase.getPokemons();
          final entity = pokemons.map((e) => PokemonEntity(name: e.name,url: e.url)).toList();
          print("entity ===== $entity");
      // state = PokedexState(loading: false, data: pokemons);
      state = PokedexState(loading: false, data: entity);
    } catch (e) {
       print("getPokemons error = $e");
      state = PokedexState(error: e.toString(), loading: false);
    }
  }

  Future<void> clearHiveDatabase () async{
   clearHiveDatabaseUsecase.clearHiveDatabase();
  }
}
