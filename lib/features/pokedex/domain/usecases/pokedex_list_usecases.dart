
import 'package:pokedex/core/network/api_response.dart';
import 'package:pokedex/features/pokedex/domain/repository/pokedex_repo.dart';

class PokedexListUsecases {
  final PokedexRepo pokedexRepo;
  PokedexListUsecases(this.pokedexRepo);

  Future<ApiResponse> getPokedexList() async{
    final list = pokedexRepo.getPokedexList();
    return list;
  }

}