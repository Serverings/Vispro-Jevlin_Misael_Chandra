enum GameStatus {
  backlog,
  playing,
  finished,
  dropped,
}

class Game {
  final String title;
  final String genre;
  final String description;
  final GameStatus status;
  final int progress;
  final String? imageAsset;

  const Game({
    required this.title,
    required this.genre,
    required this.description,
    required this.status,
    required this.progress,
    this.imageAsset,
  });
}