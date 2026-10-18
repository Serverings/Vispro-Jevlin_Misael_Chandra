import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/widgets/game_search_bar.dart';
import 'package:homework2/features/games/presentation/widgets/status_filter.dart';


class LibraryHeader extends StatelessWidget {
  static const double _filterWidth = 240;

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final GameStatus? selectedStatus;
  final ValueChanged<GameStatus?> onStatusChanged;
  final int resultCount;

  final bool wide;

  const LibraryHeader({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.selectedStatus,
    required this.onStatusChanged,
    required this.resultCount,
    required this.wide,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget search = GameSearchBar(
      controller: searchController,
      onChanged: onSearchChanged,
    );
    final Widget filter = GameStatusFilter(
      selectedStatus: selectedStatus,
      onChanged: onStatusChanged,
    );

    return Padding(
      padding: AppSpacing.pageTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: search),
                const SizedBox(width: AppSpacing.md),
                SizedBox(width: _filterWidth, child: filter),
              ],
            )
          else ...[
            search,
            const SizedBox(height: AppSpacing.md),
            filter,
          ],
          const SizedBox(height: AppSpacing.lg),
          Text(
            '$resultCount ${resultCount == 1 ? 'game' : 'games'}',
            style: theme.textTheme.labelLarge
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}