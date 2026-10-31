import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/habit.dart';

final habitBoxProvider = Provider<Box<Habit>>((ref) => Hive.box<Habit>('habits'));

final habitsProvider = StateNotifierProvider<HabitsNotifier, List<Habit>>((ref) {
  return HabitsNotifier(ref.read(habitBoxProvider));
});

class HabitsNotifier extends StateNotifier<List<Habit>> {
  final Box<Habit> _box;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  HabitsNotifier(this._box) : super(_box.values.toList()) {
    _listenToCloud();
  }

  void _listenToCloud() {
    if (_uid == null) return;
    _db.collection('users').doc(_uid).collection('habits').snapshots().listen((snapshot) {
      bool changed = false;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        final cloudHabit = Habit(
          id: doc.id,
          name: data['name'],
          colorValue: data['colorValue'],
          emoji: data['emoji'],
          completedDates: List<String>.from(data['completedDates']),
          targetDaysPerWeek: data['targetDaysPerWeek'],
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        );
        if (!_box.containsKey(cloudHabit.id)) {
          _box.put(cloudHabit.id, cloudHabit);
          changed = true;
        }
      }
      if (changed) state = _box.values.toList();
    });
  }

  Future<void> add(Habit habit) async {
    await _box.put(habit.id, habit);
    state = _box.values.toList();
    if (_uid != null) {
      await _db.collection('users').doc(_uid).collection('habits').doc(habit.id).set(habit.toMap());
    }
  }

  void toggle(Habit habit, DateTime date) {
    habit.toggle(date);
    state = [..._box.values];
    if (_uid != null) {
      _db.collection('users').doc(_uid).collection('habits').doc(habit.id).update({
        'completedDates': habit.completedDates,
      });
    }
  }

  Future<void> remove(String id) async {
    await _box.delete(id);
    state = _box.values.toList();
    if (_uid != null) {
      await _db.collection('users').doc(_uid).collection('habits').doc(id).delete();
    }
  }
}