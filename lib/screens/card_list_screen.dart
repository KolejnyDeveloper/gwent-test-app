import 'package:flutter/material.dart';
import '../data/tempcards.dart';
import '../models/card_model.dart';
import '../widgets/card_tile.dart';
import 'card_details_screen.dart';


class CardListScreen extends StatelessWidget {
  final void Function(GameCard) onAddToDeck;

  const CardListScreen({
    super.key,
    required this.onAddToDeck,
  });

  @override
  Widget build(BuildContext context) {
    final cards = mockCards;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Karty"),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];

          return CardTile(
            card: card,
            onAdd: () => onAddToDeck(card),
              onOpen: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CardDetailsScreen(
                      card: card,
                    ),
                  ),
                );
              },
          );
        },
      ),
    );
  }
}