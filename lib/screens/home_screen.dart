import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_tile.dart';
import 'add_habit_screen.dart';
import '../models/daily_quote.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    final today = DateTime.now();
    final quote = DailyQuote.getTodayQuote();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Daha yumuşak bir arka plan
      appBar: AppBar(
        title: const Text('Alışkanlıklarım', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // Günlük İlham Kartı
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.yellowAccent),
                      SizedBox(width: 8),
                      Text('Günün İlhamı', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    quote,
                    style: const TextStyle(color: Colors.white, fontSize: 15, fontStyle: FontStyle.italic, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          
          // Alışkanlık Listesi Başlığı
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text('Bugünkü Görevlerin', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
          ),

          // Liste veya Boş Durum
          habits.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.checklist_rtl, size: 80, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        const Text('Henüz bir alışkanlığın yok.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => HabitTile(habit: habits[index], date: today),
                    childCount: habits.length,
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddHabitScreen())),
        icon: const Icon(Icons.add),
        label: const Text('Yeni Ekle'),
        backgroundColor: const Color(0xFF0083B0),
      ),
    );
  }
}