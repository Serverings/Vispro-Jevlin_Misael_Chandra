import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:homework2/core/layout/breakpoints.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/screens/game_detail_screen.dart';
import 'package:homework2/features/games/presentation/widgets/brand_title.dart';
import 'package:homework2/features/games/presentation/widgets/empty_game_state.dart';
import 'package:homework2/features/games/presentation/widgets/game_card.dart';
import 'package:homework2/features/games/presentation/widgets/library_header.dart';

class GameLibraryScreen extends StatefulWidget {
  final List<Game> games;

  const GameLibraryScreen({super.key, required this.games});

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

    Widget cardAt(int index) => GameCard(
          game: games[index],
          onTap: () => _openGameDetail(games[index]),
        );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: const BrandTitle(),
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