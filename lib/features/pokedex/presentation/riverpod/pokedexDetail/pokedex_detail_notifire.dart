import 'package:flutter_riverpod/legacy.dart';
import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/features/pokedex/domain/usecases/pokedex_detail_usecase.dart';
import 'package:pokedex/features/pokedex/presentation/riverpod/pokedexDetail/pokedex_detail_state.dart';

class PokedexDetailNotifire extends StateNotifier<PokedexDetailState> {
  final PokedexDetailUsecase usecase;

  PokedexDetailNotifire(this.usecase, String id)
      : super(PokedexDetailState()) {
    getPokedexDetail(id);
  }

  Future<void> getPokedexDetail(String id) async {
    state = PokedexDetailState(loading: true);

    try {
      final result = await usecase.getPokedexDetail(id);

      if (result is ApiSuccess) {
        state = PokedexDetailState(
          loading: false,
          data: result.data,
        );
      } else if (result is ApiError) {
        state = PokedexDetailState(
          loading: false,
          error: result.message,
        );
      }
    } catch (e) {
      state = PokedexDetailState(
        loading: false,
        error: e.toString(),
      );
    }
  }
}

