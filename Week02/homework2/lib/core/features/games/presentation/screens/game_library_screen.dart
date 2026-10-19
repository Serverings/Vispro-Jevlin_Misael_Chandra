import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/data/game_data.dart';
import 'package:homework2/core/features/games/models/game.dart';
import 'package:homework2/core/features/games/presentation/screens/game_detail_screen.dart';
import 'package:homework2/core/features/games/presentation/widgets/empty_game_state.dart';
import 'package:homework2/core/features/games/presentation/widgets/game_card.dart';
import 'package:homework2/core/features/games/presentation/widgets/game_search_bar.dart';
import 'package:homework2/core/features/games/presentation/widgets/status_filter.dart';

class GameLibraryScreen extends StatefulWidget {
  final List<Game> games;

  const GameLibraryScreen({super.key, this.games = gameData});

  @override
  State<GameLibraryScreen> createState() => _GameLibraryScreenState();
}

class _GameLibraryScreenState extends State<GameLibraryScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  GameStatus? _selectedStatus;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Game> get _filteredGames {
    return widget.games.where((game) {
      final bool matchesSearch =
          game.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final bool matchesStatus =
          _selectedStatus == null || game.status == _selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  void _updateSearch(String query) => setState(() => _searchQuery = query);

  void _updateStatus(GameStatus? status) =>
      setState(() => _selectedStatus = status);

  void _openGameDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Game> games = _filteredGames;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GameVault',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      // SafeArea keeps the last card out from under the gesture bar.
      // (The AppBar already handles the notch.)
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool wide = constraints.maxWidth >= 600;
            final double textScale = math.max(
              1.0,
              MediaQuery.textScalerOf(context).scale(14) / 14,
            );

            // One scroll view for everything: with the keyboard open on a
            // short screen the search field and filter scroll away instead
            // of overflowing.
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      children: [
                        GameSearchBar(
                          controller: _searchController,
                          onChanged: _updateSearch,
                        ),
                        const SizedBox(height: 16),
                        GameStatusFilter(
                          key: ValueKey(_selectedStatus),
                          selectedStatus: _selectedStatus,
                          onChanged: _updateStatus,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                if (games.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyGameState(
                      message: _searchQuery.isNotEmpty
                          ? 'No games found for "$_searchQuery".'
                          : 'No games available.',
                      actionLabel: 'Clear search & filter',
                      onAction: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                          _selectedStatus = null;
                        });
                      },
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    sliver: wide
                        // Tablet: the layout changes, it does not stretch.
                        ? SliverGrid.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 360,
                              crossAxisSpacing: 12,
                              mainAxisExtent: 88 * textScale,
                            ),
                            itemCount: games.length,
                            itemBuilder: (context, index) => GameCard(
                              game: games[index],
                              onTap: () => _openGameDetail(games[index]),
                            ),
                          )
                        // Phone: lazy list.
                        : SliverList.builder(
                            itemCount: games.length,
                            itemBuilder: (context, index) => GameCard(
                              game: games[index],
                              onTap: () => _openGameDetail(games[index]),
                            ),
                          ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}