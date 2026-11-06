import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/habit.dart';

final habitBoxProvider = Provider<Box<Habit>>((ref) => Hive.box<Habit>('habits'));

final habitsProvider = StateNotifierProvider<HabitsNotifier, List<Habit>>((ref) {
  return HabitsNotifier(ref.read(habitBoxProvider));
});

class HabitsNotifier extends StateNotifier<List<Habit>> {
  final Box<Habit> _box;
  HabitsNotifier(this._box) : super(_box.values.toList());

  Future<void> add(Habit habit) async {
    await _box.put(habit.id, habit);
    state = _box.values.toList();
  }

  void toggle(Habit habit, DateTime date) {
    habit.toggle(date);
    state = [..._box.values];
  }

  Future<void> remove(String id) async {
    await _box.delete(id);
    state = _box.values.toList();
  }
}