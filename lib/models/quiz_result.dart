import 'category_model.dart';

class QuizResult {
  QuizResult({
    required this.category,
    required this.answers,
    required this.correctCount,
    required this.completedAt,
  }) : score = answers.isEmpty
           ? 0
           : (correctCount * 100 / answers.length).round();

  final CategoryModel category;
  final List<int?> answers;
  final int correctCount;
  final DateTime completedAt;
  final int score;
}
