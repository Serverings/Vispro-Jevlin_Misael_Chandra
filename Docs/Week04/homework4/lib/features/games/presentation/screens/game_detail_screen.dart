import 'package:flutter/material.dart';
import 'package:homework2/core/layout/breakpoints.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/widgets/game_cover.dart';
import 'package:homework2/features/games/presentation/widgets/status_pill.dart';

class GameDetailScreen extends StatelessWidget {
  static const double _coverAspect = 2 / 3;
  static const double _phoneCoverMaxWidth = 240;
  static const double _wideCoverWidth = 280;

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
            final bool wide = constraints.maxWidth >= Breakpoints.wide;
            final Widget cover = Hero(tag: game, child: GameCover(game: game));
            final Widget info = _GameInfo(game: game);

            return SingleChildScrollView(
              padding: AppSpacing.page,
              child: wide
                  // Wide: cover on the left, details on the right.
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: _wideCoverWidth,
                          child: AspectRatio(
                            aspectRatio: _coverAspect,
                            child: cover,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xl),
                        Expanded(child: info),
                      ],
                    )
                  // Narrow: cover on top, details below.
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: _phoneCoverMaxWidth,
                            ),
                            child: AspectRatio(
                              aspectRatio: _coverAspect,
                              child: cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
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
        const SizedBox(height: AppSpacing.sm),
        Text(
          game.genre,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: text.titleMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpacing.md),
        StatusPill(status: game.status),
        const SizedBox(height: AppSpacing.xl),
        Card.filled(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
          child: Padding(
            padding: AppSpacing.page,
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
                const SizedBox(height: AppSpacing.md),
                LinearProgressIndicator(
                  value: game.progress.clamp(0, 100) / 100,
                  minHeight: AppSpacing.sm,
                  borderRadius: AppRadius.smAll,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'About',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.sm),
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