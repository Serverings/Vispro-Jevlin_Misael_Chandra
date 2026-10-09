import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/models/game.dart';

/// Cover art that fills whatever size its parent gives it.
/// Falls back to a gradient when there is no image or the file is missing.
class GameCover extends StatelessWidget {
  final Game game;
  final double radius;

  const GameCover({super.key, required this.game, this.radius = 12});

  @override
  Widget build(BuildContext context) {
    final Widget placeholder = _CoverPlaceholder(title: game.title);
    final String? path = game.imageAsset;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: path == null
          ? placeholder
          : Image.asset(
              path,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              cacheWidth: 600,
              errorBuilder: (context, error, stackTrace) => placeholder,
            ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  final String title;

  const _CoverPlaceholder({required this.title});

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    final double hue = (title.hashCode.abs() % 360).toDouble();
    final Color a =
        HSLColor.fromAHSL(1, hue, 0.55, dark ? 0.32 : 0.55).toColor();
    final Color b =
        HSLColor.fromAHSL(1, (hue + 40) % 360, 0.60, dark ? 0.20 : 0.40)
            .toColor();

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [a, b],
        ),
      ),
      child: const Center(
        child: Icon(Icons.sports_esports, color: Colors.white70, size: 32),
      ),
    );
  }
}