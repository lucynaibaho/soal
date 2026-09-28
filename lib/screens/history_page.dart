import 'package:flutter/material.dart';

import '../models/quiz_result.dart';
import 'result_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key, required this.history});

  final List<QuizResult> history;

  String _formatTime(DateTime time) {
    final localTime = time.toLocal();
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${twoDigits(localTime.day)}/${twoDigits(localTime.month)}/${localTime.year}  ${twoDigits(localTime.hour)}:${twoDigits(localTime.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final recentResults = List<QuizResult>.of(
      history,
    )..sort((first, second) => second.completedAt.compareTo(first.completedAt));
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F4),
      appBar: AppBar(title: const Text('Riwayat Kuis')),
      body: recentResults.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 48,
                    color: Color(0xFF9AA6A2),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada riwayat kuis',
                    style: TextStyle(color: Color(0xFF6D7B78), fontSize: 15),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
              itemCount: recentResults.length,
              itemBuilder: (context, index) {
                final result = recentResults[index];
                final color = scoreColor(result.score);
                return Card(
                  margin: const EdgeInsets.only(bottom: 9),
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFE3E9E5)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: color.withValues(alpha: 0.12),
                      child: Text(
                        '${result.score}',
                        style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    title: Text(
                      result.category.name,
                      style: const TextStyle(
                        color: Color(0xFF18312F),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(_formatTime(result.completedAt)),
                    trailing: Text(
                      '${result.score}%',
                      style: TextStyle(
                        color: color,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
