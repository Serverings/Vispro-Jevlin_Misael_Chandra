import '../models/game.dart';

const List<Game> gameData = [
  Game(
    title: 'Elden Ring',
    genre: 'Action RPG',
    description:
        'An open-world action RPG with challenging combat and exploration.',
    status: GameStatus.playing,
    progress: 65,
  ),
  Game(
    title: 'The Witcher 3',
    genre: 'RPG',
    description:
        'An open-world role-playing game following the story of Geralt of Rivia.',
    status: GameStatus.backlog,
    progress: 0,
  ),
  Game(
    title: 'Hades',
    genre: 'Roguelike',
    description:
        'A fast-paced action game about escaping the Underworld.',
    status: GameStatus.finished,
    progress: 100,
  ),
  Game(
    title: 'Cyberpunk 2077',
    genre: 'Action RPG',
    description:
        'An open-world RPG set in the futuristic Night City.',
    status: GameStatus.backlog,
    progress: 0,
  ),
];