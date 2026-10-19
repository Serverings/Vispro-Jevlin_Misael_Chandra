import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/utils/game_status_style.dart';

class StatusPill extends StatelessWidget {
  static const double _dotSize = 6;

  final GameStatus status;
  final String? label;

  const StatusPill({super.key, required this.status, this.label});

  @override
  Widget build(BuildContext context) {
    final Color color = status.color(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: AppRadius.pillAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _dotSize,
            height: _dotSize,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              label ?? status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}