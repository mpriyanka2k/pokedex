import 'package:flutter_riverpod/legacy.dart';
import 'package:pokedex/core/di/injection.dart';
import 'package:pokedex/core/network/network_info.dart';
import 'package:pokedex/features/pokedex/domain/usecases/clear_hive_database_usecase.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemon_list_usecase.dart';
import 'package:pokedex/features/pokedex/domain/usecases/pokedex_list_usecases.dart';
import 'package:pokedex/features/pokedex/domain/usecases/save_pokemons_usecase.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedex/pokedex_notifire.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedex/pokedex_state.dart';

final pokedexProvider = StateNotifierProvider<PokedexNotifier, PokedexState>(
  (ref) => PokedexNotifier(
    locator<PokedexListUsecases>(),
    locator<SavePokemonsUsecase>(),
    locator<GetPokemonListUsecase>(),
    locator<ClearHiveDatabaseUsecase>(),
    locator<NetworkInfo>(),
    ref

  ),
);
