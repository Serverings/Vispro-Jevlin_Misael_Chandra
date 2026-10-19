import 'package:flutter/material.dart';
import 'package:homework2/core/layout/breakpoints.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/utils/game_status_style.dart';
import 'package:homework2/features/games/presentation/widgets/detail_cover.dart';
import 'package:homework2/features/games/presentation/widgets/status_pill.dart';

class GameDetailScreen extends StatelessWidget {
  static const double _coverAspect = 2 / 3;
  static const double _phoneCoverMaxWidth = 220;
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
            final Widget info = _GameInfo(game: game);

            return SingleChildScrollView(
              child: wide
                  ? Padding(
                      padding: AppSpacing.page,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: _wideCoverWidth,
                            child: AspectRatio(
                              aspectRatio: _coverAspect,
                              child: DetailPoster(game: game),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xl),
                          Expanded(child: info),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DetailBackdrop(
                          game: game,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppSpacing.lg,
                              AppSpacing.lg,
                              AppSpacing.lg,
                              AppSpacing.xl,
                            ),
                            child: Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: _phoneCoverMaxWidth,
                                ),
                                child: AspectRatio(
                                  aspectRatio: _coverAspect,
                                  child: DetailPoster(game: game),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: AppSpacing.page, child: info),
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
                  color: game.status.color(context),
                  backgroundColor:
                      game.status.color(context).withValues(alpha: 0.16),
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