import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/models/game.dart';

class GameStatusFilter extends StatelessWidget {
  final GameStatus? selectedStatus;
  final ValueChanged<GameStatus?> onChanged;

  const GameStatusFilter({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<GameStatus?>(
      key: ValueKey(selectedStatus),
      initialValue: selectedStatus,
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Filter by status',
        border: OutlineInputBorder(),
      ),
      items: [
        const DropdownMenuItem<GameStatus?>(value: null, child: Text('All')),
        ...GameStatus.values.map(
          (status) => DropdownMenuItem<GameStatus?>(
            value: status,
            child: Text(status.name, overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}