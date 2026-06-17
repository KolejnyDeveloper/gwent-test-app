import 'package:flutter/material.dart';
import 'package:gwenttestapp/screens/profile_screen.dart';
//import '../data/tempcards.dart';
import '../models/card_model.dart';
import '../widgets/card_tile.dart';
import 'card_details_screen.dart';
import '../data/card_repository.dart';


class CardListScreen extends StatefulWidget {
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
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  final repo = CardRepository();

  late Future<List<GameCard>> futureCards;

  @override
  void initState() {
    super.initState();
    futureCards = repo.getCards();
  }

  Future<void> refreshCards() async {
    await repo.refresh();

    setState(() {
      futureCards = repo.getCards();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  addedCards: widget.addedCards,
                  removedCards: widget.removedCards,
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refreshCards,
          ),
        ],
      ),
      body: FutureBuilder<List<GameCard>>(
        future: futureCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nie udało się pobrać kart'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureCards = repo.getCards();
                      });
                    },
                    child: const Text('Spróbuj ponownie'),
                  ),
                ],
              ),
            );
          }

          final cards = snapshot.data ?? [];

          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];

              return CardTile(
                card: card,
                onAdd: () {
                  widget.onAddToDeck(card);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Dodano ${card.name}'),
                      duration: const Duration(seconds: 2),
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
          );
        },
      ),
    );
  }
}

