import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/quiz_result.dart';
import 'history_page.dart';
import 'home_page.dart';
import 'quiz_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key, this.initialHistory = const []});

  final List<QuizResult> initialHistory;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late final List<QuizResult> _history = List.of(widget.initialHistory);

  void _addResult(QuizResult result) {
    setState(() => _history.add(result));
  }

  void _openQuiz(CategoryModel category) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) => QuizPage(
          category: category,
          onFinish: _addResult,
          history: _history,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(history: _history, onSelectCategory: _openQuiz),
      HistoryPage(history: _history),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFF176B66),
        unselectedItemColor: const Color(0xFF7B8986),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_rounded),
            label: 'Riwayat (${_history.length})',
          ),
        ],
      ),
    );
  }
}
