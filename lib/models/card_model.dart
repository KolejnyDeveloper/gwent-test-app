class GameCard {
  final int id;
  final String name;
  final int provisions;
  final String faction;
  final List<String> tags;
  final int imageUrl;
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

  Map<String, dynamic> toJson() => {
    'id': {
      'card': id,
      'art': imageUrl
    },
    'name': name,
    'attributes':
    {
      'provision': provisions,
      'faction': faction,
    },
    'category': tags,
    'imageUrl': imageUrl,
    'flavor': description,
  };

  factory GameCard.fromJson(Map json) => GameCard(
    id: json['id']['card'],
    name: json['name'],
    provisions: json['attributes']['provision'],
    faction: json['attributes']['faction'],
    tags: json['category'] == null
        ? []
        : json['category']
        .toString()
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList(),
    imageUrl: json['id']['art'] ?? -1,
    description: json['flavor'] ?? '',
  );
}