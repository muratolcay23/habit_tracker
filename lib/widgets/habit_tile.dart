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
    final done = habit.isCompletedOn(date);
    final color = Color(habit.colorValue);
    final iconData = IconData(int.parse(habit.emoji), fontFamily: 'MaterialIcons');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(iconData, color: color, size: 28),
          ),
        ),
        title: Text(
          habit.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            decoration: done ? TextDecoration.lineThrough : null,
            color: done ? Colors.grey : Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              const Icon(Icons.local_fire_department, size: 16, color: Colors.orange),
              const SizedBox(width: 4),
              Text('${habit.currentStreak} günlük seri', style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        trailing: GestureDetector(
          onTap: () => ref.read(habitsProvider.notifier).toggle(habit, date),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: done ? color : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: done ? color : Colors.grey.shade300, width: 2),
            ),
            child: done
                ? const Icon(Icons.check, color: Colors.white, size: 24)
                : null,
          ),
        ),
      ),
    );
  }
}