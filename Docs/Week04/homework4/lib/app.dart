import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/data/game_data.dart';
import 'package:homework2/core/features/games/models/game.dart';
import 'package:homework2/core/features/games/presentation/screens/game_library_screen.dart';
import 'package:homework2/core/theme/app_theme.dart';

class GameVaultApp extends StatelessWidget {
  final List<Game> games;
  final ThemeMode themeMode;

  const GameVaultApp({
    super.key,
    this.games = gameData,
    this.themeMode = ThemeMode.system,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameVault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: GameLibraryScreen(games: games),
    );
  }
}