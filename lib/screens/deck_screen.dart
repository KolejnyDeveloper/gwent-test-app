import 'package:flutter/material.dart';
import '../data/tempcards.dart';
import '../models/card_model.dart';


class DeckScreen extends StatelessWidget {
  final List<GameCard> deck;
  final void Function(GameCard) onRemove;

  const DeckScreen({
    super.key,
    required this.deck,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Deck"),
      ),
      body: ListView.builder(
        itemCount: deck.length,
        itemBuilder: (context, index) {
          final card = deck[index];

          return ListTile(
            title: Text('${card.provisions} | ${card.name}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onRemove(card),
            ),
          );
        },
      ),
    );
  }
}