import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final int addedCards;
  final int removedCards;

  const ProfileScreen({
    super.key,
    required this.addedCards,
    required this.removedCards,
  });

  @override
  Widget build(BuildContext context) {
    //final totalActions = addedCards + removedCards;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil gracza"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            ),

            const SizedBox(height: 12),

            const Text(
              "Giewont",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            Column(
              children: [
                ProfileStatRow(
                  icon: Icons.add,
                  iconColor: Colors.green,
                  label: "Dodane karty",
                  value: "$addedCards",
                ),
                const Divider(height: 1),

                ProfileStatRow(
                  icon: Icons.remove,
                  iconColor: Colors.red,
                  label: "Usunięte karty",
                  value: "$removedCards",
                ),
                const Divider(height: 1),

                ProfileStatRow(
                  icon: Icons.sim_card,
                  iconColor: Colors.blue,
                  label: "Łączne akcje",
                  value: "${addedCards + removedCards}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileStatRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const ProfileStatRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 4,
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}