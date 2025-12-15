import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/core/flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokedex/core/hive/hive_services.dart';
import 'package:pokedex/core/network/api_service.dart';
import 'package:pokedex/core/network/network_info.dart';
import 'package:pokedex/core/network/token_refresh_service.dart';
import 'package:pokedex/core/utils/encryption_service.dart';
import 'package:pokedex/features/pokedex/data/datasources/local_data_sources/pokedex_local_datasources.dart';
import 'package:pokedex/features/pokedex/data/datasources/remote_data_sources/pokedex_remote_datasources.dart';
import 'package:pokedex/features/pokedex/data/repository/pokedex_rep_impl.dart';
import 'package:pokedex/features/pokedex/domain/repository/pokedex_repo.dart';
import 'package:pokedex/features/pokedex/domain/usecases/clear_hive_database_usecase.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_pokemon_list_usecase.dart';
import 'package:pokedex/features/pokedex/domain/usecases/pokedex_detail_usecase.dart';
import 'package:pokedex/features/pokedex/domain/usecases/pokedex_list_usecases.dart';
import 'package:pokedex/features/pokedex/domain/usecases/save_pokemons_usecase.dart';

final locator = GetIt.instance;
Future<void> init() async {
  locator.registerLazySingleton(() => FlutterSecureStorages());

  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: "https://pokeapi.co/api/v2/pokemon/",
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    ),
  );

  // Optional: if your code uses instanceName "refresh_dio"
  locator.registerLazySingleton<Dio>(() => Dio(), instanceName: "refresh_dio");

  locator.registerLazySingleton(() => Connectivity());

  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locator<Connectivity>()),
  );

  locator.registerLazySingleton<TokenRefreshService>(
    () => TokenRefreshService(locator<Dio>(), locator<FlutterSecureStorages>()),
  );

  locator.registerLazySingleton(
    () => ApiService(
      locator<Dio>(),
      locator<NetworkInfo>(),
      locator<FlutterSecureStorages>(),
      locator<TokenRefreshService>(),
    ),
  );

  /// Hive
  locator.registerLazySingleton<HiveService>(() => HiveService());

  ///Cryptography
  locator.registerLazySingleton<EncryptionService>(
    () => locator<EncryptionService>(),
  );

  ///Pokedex
  locator.registerLazySingleton<PokedexLocalDatasources>(() => PokedexLocalDatasources(locator<HiveService>()));
  locator.registerLazySingleton<PokedexRemoteDatasources>(
    () =>
        PokedexRemoteDatasources(locator<ApiService>(), locator<HiveService>()),
  );
  locator.registerLazySingleton<PokedexRepo>(
    () => PokedexRepImpl(locator<PokedexRemoteDatasources>(),locator<PokedexLocalDatasources>()),
  );
  locator.registerLazySingleton<PokedexListUsecases>(
    () => PokedexListUsecases(locator<PokedexRepo>()),
  );

  locator.registerLazySingleton<PokedexDetailUsecase>(
    () => PokedexDetailUsecase(locator<PokedexRepo>()),
  );

  locator.registerLazySingleton<GetPokemonListUsecase>(() => GetPokemonListUsecase(locator<PokedexRepo>()));
  locator.registerLazySingleton<SavePokemonsUsecase>(() => SavePokemonsUsecase(locator<PokedexRepo>()));
  locator.registerLazySingleton<ClearHiveDatabaseUsecase>(() => ClearHiveDatabaseUsecase(locator<PokedexRepo>()));
}
