import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;

  const GameCard({super.key, required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        title: Text(game.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(game.genre, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Text('${game.progress}%'),
      ),
    );
  }
}