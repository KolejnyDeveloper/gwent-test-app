import 'package:flutter/material.dart';
import 'package:gwenttestapp/screens/profile_screen.dart';
import '../data/tempcards.dart';
import '../models/card_model.dart';
import '../widgets/card_tile.dart';
import 'card_details_screen.dart';


class CardListScreen extends StatelessWidget {
  final void Function(GameCard) onAddToDeck;
  final int addedCards;
  final int removedCards;

  const CardListScreen({
    super.key,
    required this.onAddToDeck,
    required this.addedCards,
    required this.removedCards,
  });

  @override
  Widget build(BuildContext context) {
    final cards = mockCards;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Karty"),
          leading: IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(
                    addedCards: addedCards,
                    removedCards: removedCards,
                  ),
                ),
              );
            },
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
              onAdd: () {
                onAddToDeck(card);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Dodano ${card.name}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
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