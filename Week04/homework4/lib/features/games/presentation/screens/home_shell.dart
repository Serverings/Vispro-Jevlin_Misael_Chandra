import 'package:flutter/material.dart';
import 'package:homework2/core/layout/breakpoints.dart';
import 'package:homework2/features/games/data/game_repository.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/screens/game_library_screen.dart';
import 'package:homework2/features/games/presentation/screens/progress_screen.dart';
import 'package:homework2/features/games/presentation/widgets/games_loader.dart';

class HomeShell extends StatefulWidget {
  final GameRepository repository;

  const HomeShell({super.key, required this.repository});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final GlobalKey _bodyKey = GlobalKey();
  late Future<List<Game>> _games;
  int _index = 0;

  static const List<({IconData icon, IconData selectedIcon, String label})>
      _tabs = [
    (
      icon: Icons.library_books_outlined,
      selectedIcon: Icons.library_books,
      label: 'Library',
    ),
    (
      icon: Icons.insights_outlined,
      selectedIcon: Icons.insights,
      label: 'Progress',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _games = widget.repository.fetchGames();
  }

  void _select(int index) => setState(() => _index = index);

  void _reload() => setState(() => _games = widget.repository.fetchGames());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _select(0);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool wide = constraints.maxWidth >= Breakpoints.wide;

          return Scaffold(
            body: Row(
              children: [
                if (wide) ...[
                  NavigationRail(
                    selectedIndex: _index,
                    onDestinationSelected: _select,
                    labelType: NavigationRailLabelType.all,
                    destinations: [
                      for (final tab in _tabs)
                        NavigationRailDestination(
                          icon: Icon(tab.icon),
                          selectedIcon: Icon(tab.selectedIcon),
                          label: Text(tab.label),
                        ),
                    ],
                  ),
                  const VerticalDivider(width: 1),
                ],
                Expanded(
                  child: GamesLoader(
                    future: _games,
                    onRetry: _reload,
                    builder: (games) => IndexedStack(
                      key: _bodyKey,
                      index: _index,
                      children: [
                        GameLibraryScreen(games: games),
                        ProgressScreen(
                          games: games,
                          onBrowseLibrary: () => _select(0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: wide
                ? null
                : NavigationBar(
                    selectedIndex: _index,
                    onDestinationSelected: _select,
                    destinations: [
                      for (final tab in _tabs)
                        NavigationDestination(
                          icon: Icon(tab.icon),
                          selectedIcon: Icon(tab.selectedIcon),
                          label: tab.label,
                        ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}