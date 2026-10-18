import 'package:flutter/material.dart';
import 'package:homework2/core/layout/breakpoints.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/screens/game_detail_screen.dart';
import 'package:homework2/features/games/presentation/widgets/empty_game_state.dart';
import 'package:homework2/features/games/presentation/widgets/game_card.dart';
import 'package:homework2/features/games/presentation/widgets/progress_summary.dart';

class ProgressScreen extends StatelessWidget {
  final List<Game> games;
  final VoidCallback onBrowseLibrary;

  const ProgressScreen({
    super.key,
    required this.games,
    required this.onBrowseLibrary,
  });

  void _openGameDetail(BuildContext context, Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Game> active = games
        .where((g) =>
            g.status == GameStatus.playing || g.status == GameStatus.finished)
        .toList();

    return Scaffold(
      // The HomeShell already resizes for the keyboard.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('My Progress')),
      body: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.topCenter,
          // Keeps the list readable on tablets instead of stretching it.
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: Breakpoints.contentMaxWidth),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: AppSpacing.page,
                  sliver: SliverToBoxAdapter(
                    child: ProgressSummary(games: games),
                  ),
                ),
                if (active.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyGameState(
                      message: 'No games in progress yet.',
                      actionLabel: 'Browse library',
                      onAction: onBrowseLibrary,
                    ),
                  )
                else
                  SliverPadding(
                    padding: AppSpacing.pageBody,
                    sliver: SliverList.separated(
                      itemCount: active.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) => GameCard(
                        game: active[index],
                        useHero: false,
                        onTap: () => _openGameDetail(context, active[index]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}