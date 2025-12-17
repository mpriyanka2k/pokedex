import 'package:flutter_riverpod/legacy.dart';
import 'package:pokedex/core/di/injection.dart';
import 'package:pokedex/features/pokedex/domain/usecases/pokedex_detail_usecase.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedexDetail/pokedex_detail_notifire.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedexDetail/pokedex_detail_state.dart';

final pokedexDetailProvider =
    StateNotifierProvider.family<PokedexDetailNotifire, PokedexDetailState,String>(
      (ref,id) => PokedexDetailNotifire(locator<PokedexDetailUsecase>(),id),
    );
