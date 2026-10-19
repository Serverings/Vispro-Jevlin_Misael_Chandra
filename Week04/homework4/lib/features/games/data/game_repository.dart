import 'package:homework2/features/games/models/game.dart';

abstract interface class GameRepository {
  Future<List<Game>> fetchGames();
}