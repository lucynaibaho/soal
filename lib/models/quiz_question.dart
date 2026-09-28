class QuizQuestion {
  const QuizQuestion({
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  final String text;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
}
