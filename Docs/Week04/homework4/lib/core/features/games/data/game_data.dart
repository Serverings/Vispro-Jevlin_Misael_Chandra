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
  Game(
    title: 'Stardew Valley',
    genre: 'Simulation',
    description:
        'A farming simulation game where players can grow crops, raise animals, and build relationships.',
    status: GameStatus.playing,
    progress: 40,
  ),
  
  Game(
  title: 'Judul game yang sangat sangat panjang sekali untuk menguji ellipsis di kartu',
  genre: 'Genre yang juga sangat panjang sekali untuk menguji ellipsis',
  description:
  'Deskripsi panjang Sekali yang tidak ada duanya untuk menguji ellipsis di kartu dan memastikan bahwa teks yang panjang tidak merusak tampilan kartu dan tetap terlihat rapi dan teratur di dalam aplikasi dan membantu Jevlin untuk menaklukan dunia serta vispro (amin).',
  status: GameStatus.playing,
  progress: 50,
),
];