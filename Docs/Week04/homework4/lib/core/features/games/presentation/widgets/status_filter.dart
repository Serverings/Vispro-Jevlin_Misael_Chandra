import 'package:flutter/material.dart';
import 'package:homework2/core/features/games/models/game.dart';
import 'package:homework2/core/features/games/presentation/widgets/status_pill.dart';

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
        prefixIcon: Icon(Icons.filter_list),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
      ),
      items: [
        const DropdownMenuItem<GameStatus?>(value: null, child: Text('All')),
        ...GameStatus.values.map(
          (status) => DropdownMenuItem<GameStatus?>(
            value: status,
            child: Text(
              status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}