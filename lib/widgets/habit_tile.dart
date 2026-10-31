import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';

class HabitTile extends ConsumerWidget {
  final Habit habit;
  final DateTime date;
  const HabitTile({super.key, required this.habit, required this.date});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bitti = habit.isCompletedOn(date);
    final renk = Color(habit.colorValue);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: renk.withOpacity(0.15),
          child: Text(habit.emoji, style: const TextStyle(fontSize: 20)),
        ),
        title: Text(habit.name),
        subtitle: Text('Seri: ${habit.currentStreak} gun'),
        trailing: IconButton(
          icon: Icon(bitti ? Icons.check_circle : Icons.radio_button_unchecked,
              color: bitti ? renk : null, size: 32),
          onPressed: () => ref.read(habitsProvider.notifier).toggle(habit, date),
        ),
      ),
    );
  }
}