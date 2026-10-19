import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/widgets/game_search_bar.dart';
import 'package:homework2/features/games/presentation/widgets/status_filter.dart';

class LibraryHeader extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final GameStatus? selectedStatus;
  final ValueChanged<GameStatus?> onStatusChanged;
  final int resultCount;

  const LibraryHeader({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.resultCount,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.pageTop,
          child: GameSearchBar(
            controller: searchController,
            onChanged: onSearchChanged,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GameStatusFilter(
          selectedStatus: selectedStatus,
          onChanged: onStatusChanged,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Text(
            '$resultCount ${resultCount == 1 ? 'game' : 'games'}',
            style: theme.textTheme.labelLarge
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}