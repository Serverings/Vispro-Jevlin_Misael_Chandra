import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/utils/game_status_style.dart';
import 'package:homework2/features/games/presentation/widgets/status_pill.dart';

class ProgressSummary extends StatelessWidget {
  static const double _ringSize = 80;
  static const double _ringStroke = 8;

  final List<Game> games;

  const ProgressSummary({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    final int sum = games.fold<int>(0, (total, g) => total + g.progress);
    final int average = games.isEmpty ? 0 : (sum / games.length).round();

    return Card.filled(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
      child: Padding(
        padding: AppSpacing.page,
        child: Row(
          children: [
            SizedBox(
              width: _ringSize,
              height: _ringSize,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: average.clamp(0, 100) / 100,
                    strokeWidth: _ringStroke,
                    strokeCap: StrokeCap.round,
                    backgroundColor: scheme.primary.withValues(alpha: 0.16),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: FittedBox(
                        child: Text(
                          '$average%',
                          style: text.titleMedium?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall completion',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final GameStatus status in GameStatus.values)
                        StatusPill(
                          status: status,
                          label:
                              '${status.label} · ${games.where((g) => g.status == status).length}',
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}