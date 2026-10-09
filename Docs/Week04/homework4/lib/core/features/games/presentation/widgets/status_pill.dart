import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/models/game.dart';

extension GameStatusStyle on GameStatus {
  String get label => switch (this) {
        GameStatus.backlog => 'Backlog',
        GameStatus.playing => 'Playing',
        GameStatus.finished => 'Finished',
        GameStatus.dropped => 'Dropped',
      };

  Color color(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    return switch (this) {
      GameStatus.backlog => scheme.onSurfaceVariant,
      GameStatus.playing => scheme.primary,
      GameStatus.finished =>
        dark ? const Color(0xFF6FCF97) : const Color(0xFF1E7B47),
      GameStatus.dropped => scheme.error,
    };
  }
}

class StatusPill extends StatelessWidget {
  final GameStatus status;

  const StatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final Color color = status.color(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}