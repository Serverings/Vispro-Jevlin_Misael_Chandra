import 'package:flutter/material.dart';
import 'package:homework2/features/games/presentation/widgets/brand_title.dart';
import 'package:homework2/features/games/presentation/widgets/empty_game_state.dart';

class GamesErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const GamesErrorView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(centerTitle: false, title: const BrandTitle()),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: EmptyGameState(
                icon: Icons.cloud_off_outlined,
                message: 'Could not load your games.',
                actionLabel: 'Try again',
                onAction: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}