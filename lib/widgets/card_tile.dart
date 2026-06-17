import 'package:flutter/material.dart';
import '../data/tempcards.dart';
import '../models/card_model.dart';

class CardTile extends StatelessWidget {
  final GameCard card;
  final VoidCallback onAdd;
  final VoidCallback onOpen;

  const CardTile({
    super.key,
    required this.card,
    required this.onAdd,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      onLongPress: onOpen,
      child: Card(
        child: SizedBox(
          height: 90,
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Center(
                  child: Text(
                    card.provisions.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "${card.faction} • ${card.tags.join(', ')}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: 70,
                color: Colors.grey.shade300,
                child: Image.network(card.imageUrl != "" ?
                  'https://gwent.one/image/gwent/assets/card/art/low/${card.imageUrl}.jpg': "https://media1.tenor.com/m/x8v1oNUOmg4AAAAd/rickroll-roll.gif",
                  //'https://www.gifcen.com/wp-content/uploads/2023/05/rickroll-gif-3.gif': "https://media1.tenor.com/m/x8v1oNUOmg4AAAAd/rickroll-roll.gif",
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}