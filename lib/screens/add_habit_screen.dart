import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../models/habit_template.dart';

class AddHabitScreen extends ConsumerStatefulWidget {
  const AddHabitScreen({super.key});
  @override
  ConsumerState<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Tümü';
  HabitTemplate? _selectedTemplate;
  int _target = 7;

  final List<String> _categories = ['Tümü', 'Sağlık', 'Spor', 'Eğitim', 'Yaşam'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_selectedTemplate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen bir alışkanlık seçin.')));
      return;
    }

    final habit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _selectedTemplate!.name,
      colorValue: _selectedTemplate!.color.value,
      emoji: _selectedTemplate!.icon.codePoint.toString(), // İkon kodunu string olarak saklıyoruz
      completedDates: [],
      targetDaysPerWeek: _target,
      createdAt: DateTime.now(),
    );
    await ref.read(habitsProvider.notifier).add(habit);
    if (mounted) Navigator.pop(context);
  }

  List<HabitTemplate> get _filteredTemplates {
    return habitTemplates.where((template) {
      final matchesSearch = template.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Tümü' || template.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Alışkanlık Ekle'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Kaydet', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Alışkanlık ara... (örn: su, kitap)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          // Kategori Filtreleri
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = category);
                    },
                  ),
                );
              },
            ),
          ),

          // Sonuç Listesi
          Expanded(
            child: _filteredTemplates.isEmpty
                ? const Center(child: Text('Aramanızla eşleşen alışkanlık bulunamadı.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredTemplates.length,
                    itemBuilder: (context, index) {
                      final template = _filteredTemplates[index];
                      final isSelected = _selectedTemplate == template;
                      return Card(
                        elevation: isSelected ? 4 : 0,
                        color: isSelected ? template.color.withOpacity(0.1) : Colors.white,
                        margin: const EdgeInsets.only(bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: isSelected ? template.color : Colors.grey.shade200,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: template.color.withOpacity(0.2),
                            child: Icon(template.icon, color: template.color),
                          ),
                          title: Text(template.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(template.category),
                          trailing: isSelected ? Icon(Icons.check_circle, color: template.color) : null,
                          onTap: () => setState(() => _selectedTemplate = template),
                        ),
                      );
                    },
                  ),
          ),

          // Alt Kısım: Hedef Belirleme
          if (_selectedTemplate != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Seçilen: ${_selectedTemplate!.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Haftalık Hedef:'),
                      Text('$_target Gün', style: TextStyle(color: _selectedTemplate!.color, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: _target.toDouble(),
                    min: 1,
                    max: 7,
                    divisions: 6,
                    activeColor: _selectedTemplate!.color,
                    onChanged: (v) => setState(() => _target = v.round()),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}