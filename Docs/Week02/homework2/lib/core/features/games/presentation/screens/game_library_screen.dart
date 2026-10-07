import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/data/game_data.dart';
import 'package:homework2/core/features/games/models/game.dart';
import 'package:homework2/core/features/games/presentation/screens/game_detail_screen.dart';
import 'package:homework2/core/features/games/presentation/widgets/empty_game_state.dart';
import 'package:homework2/core/features/games/presentation/widgets/game_card.dart';
import 'package:homework2/core/features/games/presentation/widgets/game_search_bar.dart';
import 'package:homework2/core/features/games/presentation/widgets/status_filter.dart';

class GameLibraryScreen extends StatefulWidget {
  const GameLibraryScreen({super.key});

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
    return gameData.where((game) {
      final bool matchesSearch = game.title.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final bool matchesStatus =
          _selectedStatus == null || game.status == _selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  void _updateSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _updateStatus(GameStatus? status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  void _openGameDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailScreen(game: game),
      ),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GameSearchBar(
              controller: _searchController,
              onChanged: _updateSearch,
            ),
            const SizedBox(height: 16),
            GameStatusFilter(
              selectedStatus: _selectedStatus,
              onChanged: _updateStatus,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: games.isEmpty
                  ? EmptyGameState(
                      message: _searchQuery.isNotEmpty
                          ? 'No games found for "$_searchQuery".'
                          : 'No games available.',
                    )
                  : ListView.builder(
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        final Game game = games[index];

                        return GameCard(
                          game: game,
                          onTap: () => _openGameDetail(game),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}