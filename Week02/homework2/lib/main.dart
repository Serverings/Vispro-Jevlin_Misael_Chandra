// import 'package:flutter/material.dart';
// import 'package:homework2/app.dart';

// void main() {
//   runApp(const GameVaultApp());
// }

import 'package:flutter/material.dart';
import 'package:homework2/app.dart';
import 'package:homework2/core/features/games/data/game_data.dart';
import 'package:homework2/core/features/games/models/game.dart';

const String _demo = String.fromEnvironment('DEMO');

void main() {
  final String long200 = List.filled(200, 'W').join();

  final List<Game> games = switch (_demo) {
    'long' => [
        Game(
          title: long200,
          genre: long200,
          description: long200,
          status: GameStatus.playing,
          progress: 100,
        ),
        ...gameData,
      ],
    'empty' => const <Game>[],
    'big' => List.generate(
        500,
        (i) => Game(
          title: 'Game ${i + 1}',
          genre: 'Genre ${i % 7}',
          description: 'Description ${i + 1}',
          status: GameStatus.values[i % GameStatus.values.length],
          progress: i % 101,
        ),
      ),
    _ => gameData,
  };

  runApp(GameVaultApp(games: games));
}