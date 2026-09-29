import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/data/game_data.dart';
import 'package:homework2/core/features/games/models/game.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Game> activeGames = gameData
        .where(
          (game) =>
              game.status == GameStatus.playing ||
              game.status == GameStatus.finished,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Progress'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: activeGames.length,
        itemBuilder: (context, index) {
          final Game game = activeGames[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: game.progress / 100,
                  ),
                  const SizedBox(height: 8),
                  Text('${game.progress}% completed'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 