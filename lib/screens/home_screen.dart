import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_tile.dart';
import 'add_habit_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    final bugun = DateTime.now();
    return Scaffold(
      appBar: AppBar(title: const Text('Aliskanliklarim')),
      body: habits.isEmpty
          ? const Center(child: Padding(padding: EdgeInsets.all(32),
              child: Text('Henuz aliskanligin yok.\nSag alttaki + ile ekle.',
                  textAlign: TextAlign.center)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: habits.length,
              itemBuilder: (_, i) => HabitTile(habit: habits[i], date: bugun),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AddHabitScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}