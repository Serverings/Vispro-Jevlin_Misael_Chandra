import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/utils/game_status_style.dart';
import 'package:homework2/features/games/presentation/widgets/status_pill.dart';

/// Overall completion plus a count per status.
class ProgressSummary extends StatelessWidget {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Overall completion',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleSmall,
                  ),
                ),
                Text(
                  '$average%',
                  style: text.headlineSmall?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            LinearProgressIndicator(
              value: average.clamp(0, 100) / 100,
              minHeight: AppSpacing.sm,
              borderRadius: AppRadius.smAll,
            ),
            const SizedBox(height: AppSpacing.lg),
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
    );
  }
}