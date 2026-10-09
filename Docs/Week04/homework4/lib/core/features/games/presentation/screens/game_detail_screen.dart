import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/models/game.dart';
import 'package:homework2/core/features/games/presentation/widgets/game_cover.dart';
import 'package:homework2/core/features/games/presentation/widgets/status_pill.dart';

class GameDetailScreen extends StatelessWidget {
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          game.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool wide = constraints.maxWidth >= 600;
            final Widget cover = Hero(tag: game, child: GameCover(game: game));
            final Widget info = _GameInfo(game: game);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: wide
                  // Wide: cover on the left, details on the right.
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 280,
                          child: AspectRatio(aspectRatio: 2 / 3, child: cover),
                        ),
                        const SizedBox(width: 24),
                        Expanded(child: info),
                      ],
                    )
                  // Narrow: cover on top, details below.
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 240),
                            child:
                                AspectRatio(aspectRatio: 2 / 3, child: cover),
                          ),
                        ),
                        const SizedBox(height: 24),
                        info,
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _GameInfo extends StatelessWidget {
  final Game game;

  const _GameInfo({required this.game});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme text = theme.textTheme;
    final ColorScheme scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          game.title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: text.headlineSmall?.copyWith(
            color: scheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          game.genre,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: text.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        StatusPill(status: game.status),
        const SizedBox(height: 24),
        Card.filled(
          margin: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Progress',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleSmall,
                      ),
                    ),
                    Text(
                      '${game.progress}%',
                      style: text.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: game.progress.clamp(0, 100) / 100,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'About',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          game.description,
          maxLines: 12,
          overflow: TextOverflow.ellipsis,
          style: text.bodyLarge,
        ),
      ],
    );
  }
}