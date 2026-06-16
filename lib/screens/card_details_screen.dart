import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardDetailsScreen extends StatelessWidget {
  final GameCard card;

  const CardDetailsScreen({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              color: Colors.grey.shade300,
              child: Image.network(
                card.imageUrl,
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
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Provision: ${card.provisions}',
                  ),

                  Text(
                    'Frakcja: ${card.faction}',
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    children: card.tags
                        .map(
                          (tag) => Chip(
                        label: Text(tag),
                      ),
                    )
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    card.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}