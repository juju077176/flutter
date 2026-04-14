import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  final int total;
  final int completed;
  final int remaining;

  const StatsScreen({
    super.key,
    required this.total,
    required this.completed,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = total == 0 ? 0 : (completed / total * 100);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiques'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Récapitulatif', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _statRow('Total', total),
                    const Divider(),
                    _statRow('Complétées', completed),
                    const Divider(),
                    _statRow('Restantes', remaining),
                    const Divider(),
                    _statRow('Progression', '${percentage.toStringAsFixed(1)} %'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            '$value',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}