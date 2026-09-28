import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/quiz_result.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key, required this.result, required this.category});

  final QuizResult result;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembahasan')),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        itemCount: category.questions.length,
        itemBuilder: (context, index) {
          final question = category.questions[index];
          final answer = result.answers[index];
          final isCorrect = answer == question.correctAnswer;
          final statusColor = isCorrect
              ? const Color(0xFF25804C)
              : const Color(0xFFC14343);
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFE3E9E5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: statusColor,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Soal ${index + 1}. ${question.text}',
                          style: const TextStyle(
                            color: Color(0xFF18312F),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  _AnswerLine(
                    label: 'Jawaban Anda',
                    value: answer == null
                        ? 'Tidak dijawab'
                        : question.options[answer],
                    color: answer == null
                        ? const Color(0xFF7B8986)
                        : statusColor,
                  ),
                  const SizedBox(height: 7),
                  _AnswerLine(
                    label: 'Jawaban benar',
                    value: question.options[question.correctAnswer],
                    color: const Color(0xFF25804C),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question.explanation,
                    style: const TextStyle(
                      color: Color(0xFF6D7B78),
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AnswerLine extends StatelessWidget {
  const _AnswerLine({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(fontSize: 14),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(color: Color(0xFF6D7B78)),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
