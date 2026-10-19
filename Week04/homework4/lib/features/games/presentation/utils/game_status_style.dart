import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_colors.dart';
import 'package:homework2/features/games/models/game.dart';

extension GameStatusStyle on GameStatus {
  String get label => switch (this) {
        GameStatus.backlog => 'Backlog',
        GameStatus.playing => 'Playing',
        GameStatus.finished => 'Finished',
        GameStatus.dropped => 'Dropped',
      };

  Color color(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return switch (this) {
      GameStatus.backlog => scheme.onSurfaceVariant,
      GameStatus.playing => scheme.primary,
      GameStatus.finished => context.appColors.success,
      GameStatus.dropped => scheme.error,
    };
  }
}