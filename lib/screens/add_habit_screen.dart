import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';

class AddHabitScreen extends ConsumerStatefulWidget {
  const AddHabitScreen({super.key});
  @override
  ConsumerState<AddHabitScreen> createState() => _State();
}

class _State extends ConsumerState<AddHabitScreen> {
  final _kontrol = TextEditingController();
  String _emoji = 'Y';
  Color _renk = Colors.teal;
  int _hedef = 7;
  static const emojiler = ['A', 'B', 'C', 'D', 'E', 'F'];
  static const renkler = [Colors.teal, Colors.blue, Colors.purple,
      Colors.orange, Colors.red, Colors.green];

  @override
  void dispose() { _kontrol.dispose(); super.dispose(); }

  Future<void> _kaydet() async {
    final ad = _kontrol.text.trim();
    if (ad.isEmpty) return;
    final h = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: ad, colorValue: _renk.value, emoji: _emoji,
      completedDates: [], targetDaysPerWeek: _hedef, createdAt: DateTime.now(),
    );
    await ref.read(habitsProvider.notifier).add(h);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni Aliskanlik'),
          actions: [TextButton(onPressed: _kaydet, child: const Text('Kaydet'))]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        TextField(controller: _kontrol,
            decoration: const InputDecoration(
                labelText: 'Aliskanlik adi',
                hintText: 'Orn. Su ic',
                border: OutlineInputBorder())),
        const SizedBox(height: 16),
        Text('Hedef: haftada $_hedef gun'),
        Slider(value: _hedef.toDouble(), min: 1, max: 7, divisions: 6,
            onChanged: (v) => setState(() => _hedef = v.round())),
      ]),
    );
  }
}
