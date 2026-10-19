import 'package:flutter/material.dart';
import 'package:homework2/core/layout/breakpoints.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/presentation/widgets/pulse.dart';
import 'package:homework2/features/games/presentation/widgets/brand_title.dart';
import 'package:homework2/features/games/presentation/widgets/game_card_skeleton.dart';

/// Shown while the games are being fetched.
class GamesLoadingView extends StatelessWidget {
  static const int _placeholderCount = 4;

  const GamesLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The HomeShell already resizes for the keyboard.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(centerTitle: false, title: const BrandTitle()),
      body: SafeArea(
        top: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: Breakpoints.contentMaxWidth),
            child: Semantics(
              label: 'Loading games',
              child: Pulse(
                child: ListView.separated(
                  padding: AppSpacing.page,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _placeholderCount,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) => const GameCardSkeleton(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}