import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/quiz_result.dart';
import 'quiz_page.dart';
import 'review_page.dart';
import 'root_page.dart';

Color scoreColor(int score) {
  if (score >= 80) return const Color(0xFF25804C);
  if (score >= 60) return const Color(0xFFC27621);
  return const Color(0xFFC14343);
}

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.result,
    required this.category,
    required this.onFinish,
    required this.history,
  });

  final QuizResult result;
  final CategoryModel category;
  final ValueChanged<QuizResult> onFinish;
  final List<QuizResult> history;

  String get _message {
    if (result.score >= 80) return 'Luar biasa!';
    if (result.score >= 60) return 'Bagus, tingkatkan lagi';
    return 'Ayo belajar lagi';
  }

  @override
  Widget build(BuildContext context) {
    final color = scoreColor(result.score);
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Kuis')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                children: [
                  Container(
                    width: 124,
                    height: 124,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.11),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${result.score}',
                      style: TextStyle(
                        color: color,
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    category.name,
                    style: const TextStyle(
                      color: Color(0xFF6D7B78),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${result.correctCount} benar dari ${category.questions.length} soal',
                    style: const TextStyle(
                      color: Color(0xFF18312F),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              ReviewPage(result: result, category: category),
                        ),
                      ),
                      icon: const Icon(Icons.fact_check_outlined),
                      label: const Text('Lihat Pembahasan'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: () => Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => QuizPage(
                            category: category,
                            onFinish: onFinish,
                            history: history,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Ulangi Kuis'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton.icon(
                      onPressed: () => Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => RootPage(initialHistory: history),
                        ),
                        (route) => false,
                      ),
                      icon: const Icon(Icons.home_outlined),
                      label: const Text('Ke Beranda'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
