import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/widgets/game_cover.dart';
import 'package:homework2/features/games/presentation/widgets/status_pill.dart';

class GameCard extends StatelessWidget {
  static const double _coverWidth = 72;
  static const double _coverHeight = 108;


  static const double height = _coverHeight + AppSpacing.md * 2;

  final Game game;
  final VoidCallback onTap;

  final bool useHero;

  const GameCard({
    super.key,
    required this.game,
    required this.onTap,
    this.useHero = true,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme text = theme.textTheme;
    final ColorScheme scheme = theme.colorScheme;
    final Widget cover = GameCover(game: game);

    return Card.filled(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              SizedBox(
                width: _coverWidth,
                height: _coverHeight,
                child: useHero ? Hero(tag: game, child: cover) : cover,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      game.genre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    StatusPill(status: game.status),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: game.progress.clamp(0, 100) / 100,
                            minHeight: AppSpacing.sm,
                            borderRadius: AppRadius.smAll,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text('${game.progress}%', style: text.labelMedium),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}