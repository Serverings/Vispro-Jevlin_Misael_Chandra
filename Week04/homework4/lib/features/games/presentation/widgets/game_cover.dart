import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';

class GameCover extends StatelessWidget {
  final Game game;
  final BorderRadius borderRadius;

  const GameCover({
    super.key,
    required this.game,
    this.borderRadius = AppRadius.mdAll,
  });

  @override
  Widget build(BuildContext context) {
    final String? path = game.imageAsset;

    return ClipRRect(
      borderRadius: borderRadius,
      child: path == null
          ? const _CoverPlaceholder()
          : Image.asset(
              path,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              cacheWidth: 600,
              errorBuilder: (context, error, stackTrace) =>
                  const _CoverPlaceholder(),
            ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primaryContainer, scheme.tertiaryContainer],
        ),
      ),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) => Icon(
            Icons.sports_esports,
            color: scheme.onPrimaryContainer,
            size: constraints.biggest.shortestSide * 0.4,
          ),
        ),
      ),
    );
  }
}