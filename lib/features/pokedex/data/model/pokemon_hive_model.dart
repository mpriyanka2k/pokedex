import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/features/pokedex/domain/entity/pokedex_entity.dart';

part 'pokemon_hive_model.g.dart';

@HiveType(typeId: 1)
class PokemonHiveModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;

  PokemonHiveModel({
    required this.name,
    required this.url,
  });

  // Convert Entity → Model
  factory PokemonHiveModel.fromEntity(PokemonEntity entity) {
    return PokemonHiveModel(
      name: entity.name,
      url: entity.url,
    );
  }

  // Convert HiveModel → Entity
  
  
}