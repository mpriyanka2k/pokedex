import 'package:pokedex/features/pokedex/domain/repository/pokedex_repo.dart';

class ClearHiveDatabaseUsecase {
  final PokedexRepo pokedexRepo;
  ClearHiveDatabaseUsecase(this.pokedexRepo);

  Future<void> clearHiveDatabase()async{
    pokedexRepo.clearHiveDatabase();
  }
  
}