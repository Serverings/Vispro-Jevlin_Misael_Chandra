import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';

class GameCardSkeleton extends StatelessWidget {
  static const double _coverWidth = 72;
  static const double _coverHeight = 108;

  static const double _titleFraction = 0.6;
  static const double _genreFraction = 0.4;
  static const double _pillFraction = 0.3;

  const GameCardSkeleton({super.key});

  Widget _block(
    BuildContext context, {
    double? width,
    required double height,
    BorderRadius radius = AppRadius.smAll,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
        borderRadius: radius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            _block(
              context,
              width: _coverWidth,
              height: _coverHeight,
              radius: AppRadius.mdAll,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    widthFactor: _titleFraction,
                    child: _block(context, height: AppSpacing.lg),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  FractionallySizedBox(
                    widthFactor: _genreFraction,
                    child: _block(context, height: AppSpacing.md),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FractionallySizedBox(
                    widthFactor: _pillFraction,
                    child: _block(
                      context,
                      height: AppSpacing.xl,
                      radius: AppRadius.pillAll,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _block(context, height: AppSpacing.sm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}