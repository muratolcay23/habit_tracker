import 'package:flutter/material.dart';

class HabitTemplate {
  final String name;
  final IconData icon;
  final Color color;
  final String category;

  const HabitTemplate({
    required this.name,
    required this.icon,
    required this.color,
    required this.category,
  });
}

final List<HabitTemplate> habitTemplates = [
  // Saðlýk
  HabitTemplate(name: 'Su Ýç', icon: Icons.water_drop, color: Colors.blue, category: 'Saðlýk'),
  HabitTemplate(name: 'Ýlaç Al', icon: Icons.medication, color: Colors.redAccent, category: 'Saðlýk'),
  HabitTemplate(name: 'Vitamin Al', icon: Icons.medication_liquid, color: Colors.orange, category: 'Saðlýk'),
  HabitTemplate(name: 'Erken Uyu', icon: Icons.bedtime, color: Colors.indigo, category: 'Saðlýk'),
  HabitTemplate(name: 'Diþ Fýrçala', icon: Icons.brush, color: Colors.cyan, category: 'Saðlýk'),
  HabitTemplate(name: 'Saðlýklý Beslen', icon: Icons.apple, color: Colors.green, category: 'Saðlýk'),

  // Spor
  HabitTemplate(name: 'Yürüyüþ Yap', icon: Icons.directions_walk, color: Colors.green, category: 'Spor'),
  HabitTemplate(name: 'Koþu Yap', icon: Icons.directions_run, color: Colors.orangeAccent, category: 'Spor'),
  HabitTemplate(name: 'Gym / Aðýrlýk', icon: Icons.fitness_center, color: Colors.grey, category: 'Spor'),
  HabitTemplate(name: 'Yoga / Esneme', icon: Icons.self_improvement, color: Colors.purple, category: 'Spor'),
  HabitTemplate(name: 'Bisiklet Sür', icon: Icons.pedal_bike, color: Colors.teal, category: 'Spor'),

  // Eðitim & Kiþisel Geliþim
  HabitTemplate(name: 'Kitap Oku', icon: Icons.menu_book, color: Colors.brown, category: 'Eðitim'),
  HabitTemplate(name: 'Dil Öðren', icon: Icons.language, color: Colors.blueAccent, category: 'Eðitim'),
  HabitTemplate(name: 'Meditasyon Yap', icon: Icons.spa, color: Colors.cyan, category: 'Eðitim'),
  HabitTemplate(name: 'Günlük Yaz', icon: Icons.edit_note, color: Colors.amber, category: 'Eðitim'),
  HabitTemplate(name: 'Kod Yaz / Proje', icon: Icons.code, color: Colors.blueGrey, category: 'Eðitim'),

  // Günlük Yaþam
  HabitTemplate(name: 'Yataðý Topla', icon: Icons.bed, color: Colors.brown, category: 'Yaþam'),
  HabitTemplate(name: 'Ev Topla', icon: Icons.cleaning_services, color: Colors.lightBlue, category: 'Yaþam'),
  HabitTemplate(name: 'Bitkileri Sula', icon: Icons.local_florist, color: Colors.green, category: 'Yaþam'),
  HabitTemplate(name: 'Günlük Plan Yap', icon: Icons.calendar_today, color: Colors.deepPurple, category: 'Yaþam'),
  HabitTemplate(name: 'Ekran Süresini Azalt', icon: Icons.phonelink_erase, color: Colors.red, category: 'Yaþam'),
  HabitTemplate(name: 'Þükret', icon: Icons.favorite, color: Colors.pink, category: 'Yaþam'),
];
