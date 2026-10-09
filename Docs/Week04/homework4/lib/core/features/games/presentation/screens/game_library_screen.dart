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

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _selectedStatus = null;
    });
  }

  void _openGameDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Game> games = _filteredGames;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sports_esports, color: scheme.primary),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'GameVault',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool wide = constraints.maxWidth >= 600;
            final double textScale = math.max(
              1.0,
              MediaQuery.textScalerOf(context).scale(14) / 14,
            );

            final Widget search = GameSearchBar(
              controller: _searchController,
              onChanged: _updateSearch,
            );
            final Widget filter = GameStatusFilter(
              selectedStatus: _selectedStatus,
              onChanged: _updateStatus,
            );

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (wide)
                          // Wide screens: search and filter share one row.
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: search),
                              const SizedBox(width: 12),
                              SizedBox(width: 240, child: filter),
                            ],
                          )
                        else ...[
                          search,
                          const SizedBox(height: 12),
                          filter,
                        ],
                        const SizedBox(height: 16),
                        Text(
                          '${games.length} ${games.length == 1 ? 'game' : 'games'}',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 12),
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
                      onAction: _resetFilters,
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    sliver: wide
                        ? SliverGrid.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 360,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 132 * textScale,
                            ),
                            itemCount: games.length,
                            itemBuilder: (context, index) => GameCard(
                              game: games[index],
                              onTap: () => _openGameDetail(games[index]),
                            ),
                          )
                        : SliverList.separated(
                            itemCount: games.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
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