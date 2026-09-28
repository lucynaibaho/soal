import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/quiz_result.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.history,
    required this.onSelectCategory,
  });

  final List<QuizResult> history;
  final ValueChanged<CategoryModel> onSelectCategory;

  @override
  Widget build(BuildContext context) {
    final averageScore = history.isEmpty
        ? '-'
        : '${(history.fold<int>(0, (total, result) => total + result.score) / history.length).round()}%';
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 12),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Halo, Lucy Naibaho',
                  style: TextStyle(
                    color: Color(0xFF18312F),
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Siap menambah pengetahuan hari ini?',
                  style: TextStyle(color: Color(0xFF6D7B78), fontSize: 15),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: _SummaryBlock(
                        label: 'Kuis dikerjakan',
                        value: '${history.length}',
                        icon: Icons.task_alt_rounded,
                        color: const Color(0xFF176B66),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SummaryBlock(
                        label: 'Skor rata-rata',
                        value: averageScore,
                        icon: Icons.bar_chart_rounded,
                        color: const Color(0xFFB25B36),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Text(
                  'Pilih kategori',
                  style: TextStyle(
                    color: Color(0xFF18312F),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Latihan singkat, pemahaman bertambah.',
                  style: TextStyle(color: Color(0xFF6D7B78), fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
          sliver: SliverGrid.builder(
            itemCount: CategoryModel.all.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 13,
              mainAxisSpacing: 13,
              childAspectRatio: 0.98,
            ),
            itemBuilder: (context, index) {
              final category = CategoryModel.all[index];
              return _CategoryTile(
                category: category,
                onTap: () => onSelectCategory(category),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SummaryBlock extends StatelessWidget {
  const _SummaryBlock({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE3E9E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 21),
          const SizedBox(height: 9),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF6D7B78), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category, required this.onTap});

  final CategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE3E9E5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: category.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(category.icon, color: category.color, size: 25),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF18312F),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${category.questions.length} soal',
                    style: TextStyle(
                      color: category.color,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
