import 'package:homework2/features/games/data/game_data.dart';
import 'package:homework2/features/games/data/game_repository.dart';
import 'package:homework2/features/games/models/game.dart';

class InMemoryGameRepository implements GameRepository {
  final List<Game> games;
  final Duration delay;

  const InMemoryGameRepository({
    this.games = gameData,
    this.delay = const Duration(milliseconds: 900),
  });

  @override
  Future<List<Game>> fetchGames() async {
    await Future<void>.delayed(delay);
    return List<Game>.unmodifiable(games);
  }
}