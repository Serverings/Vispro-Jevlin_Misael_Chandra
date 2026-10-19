import 'package:flutter/material.dart';
import 'package:homework2/core/theme/app_spacing.dart';
import 'package:homework2/features/games/models/game.dart';
import 'package:homework2/features/games/presentation/utils/game_status_style.dart';

class GameStatusFilter extends StatelessWidget {
  final GameStatus? selectedStatus;
  final ValueChanged<GameStatus?> onChanged;

  const GameStatusFilter({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  Widget _chip(GameStatus? status, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: ChoiceChip(
        key: Key('filter-${status?.name ?? 'all'}'),
        label: Text(label),
        selected: selectedStatus == status,
        showCheckmark: false,
        onSelected: (_) => onChanged(status),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          _chip(null, 'All'),
          for (final GameStatus status in GameStatus.values)
            _chip(status, status.label),
        ],
      ),
    );
  }
}