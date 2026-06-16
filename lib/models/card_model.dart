class GameCard {
  final String id;
  final String name;
  final int provisions;
  final String faction;
  final List<String> tags;
  final String imageUrl;
  final String description;

  const GameCard({
    required this.id,
    required this.name,
    required this.provisions,
    required this.faction,
    required this.tags,
    required this.imageUrl,
    required this.description,
  });
}