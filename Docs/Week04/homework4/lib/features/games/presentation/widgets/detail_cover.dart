import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/widgets/game_cover.dart';

class DetailPoster extends StatelessWidget {
  final Game game;

  const DetailPoster({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Hero(
        tag: game,
        child: GameCover(game: game, borderRadius: AppRadius.lgAll),
      ),
    );
  }
}

class DetailBackdrop extends StatelessWidget {
  static const double _blur = 24;

  final Game game;
  final Widget child;

  const DetailBackdrop({super.key, required this.game, required this.child});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
              child: GameCover(game: game, borderRadius: BorderRadius.zero),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [scheme.surface.withValues(alpha: 0.2), scheme.surface],
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}