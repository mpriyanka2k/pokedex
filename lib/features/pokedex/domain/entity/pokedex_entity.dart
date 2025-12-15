class PokedexEntity {
  final int count;
  final String next;
  final String? previous;
  final List<PokemonEntity> results;

  const PokedexEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
}

class PokemonEntity {
  final String name;
  final String url;

  const PokemonEntity({
    required this.name,
    required this.url,
  });
}
