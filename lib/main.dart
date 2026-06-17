import 'package:flutter/material.dart';
import 'package:gwenttestapp/screens/card_list_screen.dart';
import 'package:gwenttestapp/screens/deck_screen.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'models/card_model.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

late Mixpanel mixpanel;


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //zamiast Analytycs uzylem innego podobnego w dzialaniu narzędzia do zbierania eventów
  mixpanel = await Mixpanel.init(
    "998f79c72c4d2e7159e6d88943ecaef1",
    trackAutomaticEvents: false,
    serverURL: "https://api-eu.mixpanel.com",
  );
  mixpanel.setLoggingEnabled(true);
  mixpanel.identify("test_user");

  await Hive.initFlutter();

  await Hive.openBox('cardsBox');

  runApp(const MyApp());
  mixpanel.track('App Opened');
  mixpanel.flush();
  mixpanel.track("TEST_123");
  mixpanel.flush();
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
  int addedCards = 0;
  int removedCards = 0;

  final List<GameCard> deck = [];

  void addToDeck(GameCard card) {
    setState(() {
      deck.add(card);
      addedCards++;
      mixpanel.track('Card Added');
      mixpanel.flush();
    });
  }

  void removeFromDeck(GameCard card) {
    setState(() {
      deck.remove(card);
      removedCards++;
      mixpanel.track('Card Removed');
      mixpanel.flush();
    });
  }

  void clearDeck() {
    setState(() {
      deck.clear();
      mixpanel.track('Deck Cleared');
      mixpanel.flush();
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
            addedCards: addedCards,
            removedCards: removedCards,
          ),
          DeckScreen(
            deck: deck,
            onRemove: removeFromDeck,
            onClear: clearDeck,
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