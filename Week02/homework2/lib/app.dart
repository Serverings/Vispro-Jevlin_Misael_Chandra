import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_theme.dart';
import 'package:homework2/core/features/games/presentation/screens/game_library_screen.dart';

class GameVaultApp extends StatelessWidget {
  const GameVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameVault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const GameLibraryScreen(),
    );
  }
}