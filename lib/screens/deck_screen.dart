import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../widgets/stat_tile.dart';

class DeckScreen extends StatelessWidget {
  final List<GameCard> deck;
  final void Function(GameCard) onRemove;
  final VoidCallback onClear;

  const DeckScreen({
    super.key,
    required this.deck,
    required this.onRemove,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final totalProvisions = deck.fold(
      0,
          (sum, card) => sum + card.provisions,
    );

    final totalCards = deck.length;
    final isOverProvisions = totalProvisions > 165;
    final isUnderCards = totalCards < 25;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Deck"),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: deck.isEmpty
                  ? null
                  : () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Usuwamy?"),
                    content: const Text("Ten deck zostanie stracony za zawsze... forever"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Zaniechaj"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onClear();
                        },
                        child: const Text("Usuń"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: deck.length,
              itemBuilder: (context, index) {
                final card = deck[index];

                return ListTile(
                  title: Text(
                    '${card.provisions} | ${card.name}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onRemove(card),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: const Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: StatTile(
                    icon: isOverProvisions ? Icons.warning : Icons.brunch_dining,
                    iconColor: Colors.brown.shade800,
                    label: 'Prowizje',
                    value: '$totalProvisions / 165',
                    valueColor: isOverProvisions
                        ? Colors.red.shade700
                        : Colors.brown.shade900,
                    backgroundColor: isOverProvisions
                        ? Colors.red.shade100
                        : Colors.brown.shade100,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: StatTile(
                    icon: isUnderCards ? Icons.warning : Icons.style,
                    iconColor: isUnderCards ? Colors.red.shade600 : Colors.green.shade800,
                    label: 'Ilość kart',
                    value: '$totalCards / 25',
                    valueColor: isUnderCards
                        ? Colors.red.shade700
                        : Colors.green.shade900,
                    backgroundColor: isUnderCards
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}