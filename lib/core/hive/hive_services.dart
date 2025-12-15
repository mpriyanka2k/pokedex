import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/features/pokedex/data/model/pokemon_hive_model.dart';

class HiveService {

   Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PokemonHiveModelAdapter());
    await Hive.openBox('pokemonBox');

  }

   Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

   Box<T> box<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

   Future<void> closeBox(String boxName) async {
    await Hive.box(boxName).close();
  }

   Future<void> clearBox(String boxName) async {
    await Hive.box(boxName).clear();
  }

  void register(){
    Hive.registerAdapter(PokemonHiveModelAdapter());
  }
}
