import 'package:hive_ce/hive.dart';
import '../models/card_model.dart';
import '../services/gwent_api_service.dart';

class CardRepository {
  final api = GwentApiService();
  final box = Hive.box('cardsBox');

  Future<List<GameCard>> getCards() async {
    if (box.isNotEmpty) {
      final cached = box.values
          .map((e) => GameCard.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      return cached;
    }

    try {
      final cards = await api.fetchCards();

      await box.clear();

      for (final card in cards) {
        box.put(card.id, card.toJson());
      }

      return cards;
    } catch (e) {
      throw Exception('Blad wczytywania kart: $e');
    }
  }

  Future<void> refresh() async {
    final cards = await api.fetchCards();

    await box.clear();

    for (final card in cards) {
      box.put(card.id, card.toJson());
    }
  }
}