import 'package:flutter/material.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/widgets/games_error_view.dart';
import 'package:homework2/features/games/presentation/widgets/games_loading_view.dart';

/// Turns a Future of games into one of three states:
/// loading, error (with retry), or the loaded content from [builder].
class GamesLoader extends StatelessWidget {
  final Future<List<Game>> future;
  final VoidCallback onRetry;
  final Widget Function(List<Game> games) builder;

  const GamesLoader({
    super.key,
    required this.future,
    required this.onRetry,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) return GamesErrorView(onRetry: onRetry);
        if (!snapshot.hasData) return const GamesLoadingView();
        return builder(snapshot.data!);
      },
    );
  }
}