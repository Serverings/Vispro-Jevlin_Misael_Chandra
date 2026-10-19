import '../models/game.dart';

const List<Game> gameData = [
  Game(
    title: 'Elden Ring',
    genre: 'Action RPG',
    description:
        'An open-world action RPG with challenging combat and exploration.',
    status: GameStatus.playing,
    progress: 65,
    imageAsset: 'assets/images/Eldenring.jpeg',
  ),
  Game(
    title: 'The Witcher 3',
    genre: 'RPG',
    description:
        'An open-world role-playing game following the story of Geralt of Rivia.',
    status: GameStatus.backlog,
    progress: 0,
    imageAsset: 'assets/images/TheWitcher.jpg',
  ),
  Game(
    title: 'Hades',
    genre: 'Roguelike',
    description:
        'A fast-paced action game about escaping the Underworld.',
    status: GameStatus.finished,
    progress: 100,imageAsset: 'assets/images/Hades.jpeg',
  ),
  Game(
    title: 'Cyberpunk 2077',
    genre: 'Action RPG',
    description:
        'An open-world RPG set in the futuristic Night City.',
    status: GameStatus.backlog,
    progress: 0,
    imageAsset: 'assets/images/Cyberpunk2077.jpeg',
  ),
  Game(
    title: 'Stardew Valley',
    genre: 'Simulation',
    description:
        'A farming simulation game where players can grow crops, raise animals, and build relationships.',
    status: GameStatus.playing,
    progress: 40,
    imageAsset: 'assets/images/StardewValley.png',
  ),
  Game(
    title: 'Party Club',
    genre: 'Party Game',
    description:
        'A multiplayer party game cooking with friends and competing in every place and events coming.',
    status: GameStatus.playing,
    progress: 80,
    imageAsset: 'assets/images/PartyClub.jpg',
  ),
];