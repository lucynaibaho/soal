import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/quiz_result.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
    required this.category,
    required this.onFinish,
    required this.history,
  });

  final CategoryModel category;
  final ValueChanged<QuizResult> onFinish;
  final List<QuizResult> history;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  int? _selectedOption;
  late final List<int?> _answers = List<int?>.filled(
    widget.category.questions.length,
    null,
  );
  bool _showingExitDialog = false;

  Future<void> _confirmExit() async {
    if (_showingExitDialog) return;
    _showingExitDialog = true;
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text('Progres akan hilang'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFB25B36),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    _showingExitDialog = false;
    if (shouldExit == true && mounted) Navigator.pop(context);
  }

  void _submitAnswer() {
    final questions = widget.category.questions;
    _answers[_currentIndex] = _selectedOption;
    if (_currentIndex < questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
      });
      return;
    }
    var correctCount = 0;
    for (var index = 0; index < questions.length; index++) {
      if (_answers[index] == questions[index].correctAnswer) correctCount++;
    }
    final result = QuizResult(
      category: widget.category,
      answers: List<int?>.of(_answers),
      correctCount: correctCount,
      completedAt: DateTime.now(),
    );
    widget.onFinish(result);
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) => ResultPage(
          result: result,
          category: widget.category,
          onFinish: widget.onFinish,
          history: widget.history,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.category.questions;
    final question = questions[_currentIndex];
    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            tooltip: 'Kembali',
            onPressed: _confirmExit,
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: Text(widget.category.name),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Soal ${_currentIndex + 1} dari ${questions.length}',
                      style: const TextStyle(
                        color: Color(0xFF52615E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: (_currentIndex + 1) / questions.length,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(6),
                      backgroundColor: const Color(0xFFDDE5E1),
                      color: const Color(0xFF176B66),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 27, 22, 14),
                  children: [
                    Text(
                      question.text,
                      style: const TextStyle(
                        color: Color(0xFF18312F),
                        fontSize: 23,
                        height: 1.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 21),
                    for (
                      var index = 0;
                      index < question.options.length;
                      index++
                    )
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _OptionTile(
                          label: question.options[index],
                          selected: _selectedOption == index,
                          onTap: () => setState(() => _selectedOption = index),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 8, 22, 18),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: _selectedOption == null ? null : _submitAnswer,
                    child: Text(
                      _currentIndex == questions.length - 1
                          ? 'Selesai'
                          : 'Lanjut',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? const Color(0xFF176B66)
        : const Color(0xFFDFE6E2);
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: selected ? const Color(0xFFE7F2EF) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor, width: selected ? 1.5 : 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        title: Text(label, style: const TextStyle(color: Color(0xFF18312F))),
        trailing: Icon(
          selected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: selected ? const Color(0xFF176B66) : const Color(0xFF87938F),
        ),
      ),
    );
  }
}
