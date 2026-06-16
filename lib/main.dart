import 'package:flutter/material.dart';
import 'package:gwenttestapp/screens/card_list_screen.dart';
import 'package:gwenttestapp/screens/deck_screen.dart';
import 'models/card_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zagrajmy w gwinta',
      home: const RootScreen(),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedIndex = 0;

  final List<GameCard> deck = [];

  void addToDeck(GameCard card) {
    setState(() {
      deck.add(card);
    });
  }

  void removeFromDeck(GameCard card) {
    setState(() {
      deck.remove(card);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          CardListScreen(
            onAddToDeck: addToDeck,
          ),
          DeckScreen(
            deck: deck,
            onRemove: removeFromDeck,
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Karty',
          ),
          NavigationDestination(
            icon: Icon(Icons.style),
            label: 'Deck',
          ),
        ],
      ),
    );
  }
}