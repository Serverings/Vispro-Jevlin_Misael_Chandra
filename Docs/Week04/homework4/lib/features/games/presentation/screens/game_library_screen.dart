import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:homework2/core/layout/breakpoints.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/data/game_data.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/screens/game_detail_screen.dart';
import 'package:homework2/features/games/presentation/widgets/empty_game_state.dart';
import 'package:homework2/features/games/presentation/widgets/game_card.dart';
import 'package:homework2/features/games/presentation/widgets/library_header.dart';

class GameLibraryScreen extends StatefulWidget {
  final List<Game> games;

  const GameLibraryScreen({super.key, this.games = gameData});

  @override
  State<GameLibraryScreen> createState() => _GameLibraryScreenState();
}

class _GameLibraryScreenState extends State<GameLibraryScreen> {
  static const double _maxCardWidth = 360;

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

    Widget cardAt(int index) => GameCard(
          game: games[index],
          onTap: () => _openGameDetail(games[index]),
        );

    return Scaffold(
      // The HomeShell already resizes for the keyboard.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sports_esports, color: scheme.primary),
            const SizedBox(width: AppSpacing.sm),
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
            final bool wide = constraints.maxWidth >= Breakpoints.wide;
            final double textScale = math.max(
              1.0,
              MediaQuery.textScalerOf(context).scale(14) / 14,
            );

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: LibraryHeader(
                    searchController: _searchController,
                    onSearchChanged: _updateSearch,
                    selectedStatus: _selectedStatus,
                    onStatusChanged: _updateStatus,
                    resultCount: games.length,
                    wide: wide,
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
                    padding: AppSpacing.pageBody,
                    sliver: wide
                        ? SliverGrid.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: _maxCardWidth,
                              crossAxisSpacing: AppSpacing.md,
                              mainAxisSpacing: AppSpacing.md,
                              mainAxisExtent: GameCard.height * textScale,
                            ),
                            itemCount: games.length,
                            itemBuilder: (context, index) => cardAt(index),
                          )
                        : SliverList.separated(
                            itemCount: games.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: AppSpacing.md),
                            itemBuilder: (context, index) => cardAt(index),
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