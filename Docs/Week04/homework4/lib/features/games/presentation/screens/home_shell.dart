import 'package:flutter/material.dart';
import 'package:homework2/core/layout/breakpoints.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/screens/game_library_screen.dart';
import 'package:homework2/features/games/presentation/screens/progress_screen.dart';

/// Owns the top-level navigation: a NavigationBar on phones and a
/// NavigationRail on wide screens. Both tabs get the same games list.
class HomeShell extends StatefulWidget {
  final List<Game> games;

  const HomeShell({super.key, required this.games});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  // Keeps the tabs (and the search text) alive when the layout switches
  // between phone and wide, e.g. on rotation.
  final GlobalKey _bodyKey = GlobalKey();
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

  void _select(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    // Back on the Progress tab returns to Library before leaving the app.
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
                  child: IndexedStack(
                    key: _bodyKey,
                    index: _index,
                    children: [
                      GameLibraryScreen(games: widget.games),
                      ProgressScreen(
                        games: widget.games,
                        onBrowseLibrary: () => _select(0),
                      ),
                    ],
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