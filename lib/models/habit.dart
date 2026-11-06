import 'package:hive/hive.dart';

class Habit extends HiveObject {
  String id;
  String name;
  int colorValue;
  String emoji;
  List<String> completedDates;
  int targetDaysPerWeek;
  DateTime createdAt;

  Habit({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.emoji,
    required this.completedDates,
    this.targetDaysPerWeek = 7,
    required this.createdAt,
  });

  bool isCompletedOn(DateTime date) => completedDates.contains(_key(date));

  void toggle(DateTime date) {
    final k = _key(date);
    if (completedDates.contains(k)) {
      completedDates.remove(k);
    } else {
      completedDates.add(k);
    }
    save();
  }

  int get currentStreak {
    if (completedDates.isEmpty) return 0;
    var c = DateTime.now();
    if (!isCompletedOn(c)) {
      c = c.subtract(const Duration(days: 1));
      if (!isCompletedOn(c)) return 0;
    }
    var s = 0;
    while (isCompletedOn(c)) {
      s++;
      c = c.subtract(const Duration(days: 1));
    }
    return s;
  }

  static String _key(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;
  @override
  Habit read(BinaryReader r) {
    final n = r.readByte();
    final f = <int, dynamic>{for (int i = 0; i < n; i++) r.readByte(): r.read()};
    return Habit(
      id: f[0] as String,
      name: f[1] as String,
      colorValue: f[2] as int,
      emoji: f[3] as String,
      completedDates: (f[4] as List).cast<String>(),
      targetDaysPerWeek: f[5] as int,
      createdAt: f[6] as DateTime,
    );
  }
  @override
  void write(BinaryWriter w, Habit o) {
    w..writeByte(7)
     ..writeByte(0)..write(o.id)
     ..writeByte(1)..write(o.name)
     ..writeByte(2)..write(o.colorValue)
     ..writeByte(3)..write(o.emoji)
     ..writeByte(4)..write(o.completedDates)
     ..writeByte(5)..write(o.targetDaysPerWeek)
     ..writeByte(6)..write(o.createdAt);
  }
}