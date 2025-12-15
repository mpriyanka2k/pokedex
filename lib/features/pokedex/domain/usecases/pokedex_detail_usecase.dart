import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/features/pokedex/domain/repository/pokedex_repo.dart';

class PokedexDetailUsecase {
  final PokedexRepo repo;
  PokedexDetailUsecase(this.repo);

  Future<ApiResponse> getPokedexDetail(String id) async {
    final data = repo.pokedexDetail(id);
    return data;
  }
}