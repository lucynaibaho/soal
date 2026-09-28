// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:soal/main.dart';

void main() {
  Future<void> login(WidgetTester tester) async {
    await tester.enterText(
      find.byKey(const ValueKey('username')),
      'Lucy Naibaho',
    );
    await tester.enterText(find.byKey(const ValueKey('password')), '124240040');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
  }

  testWidgets('home shows categories and empty history', (tester) async {
    await tester.pumpWidget(const MyApp());
    await login(tester);

    expect(find.text('Halo, Lucy Naibaho'), findsOneWidget);
    expect(find.text('Pengetahuan Umum'), findsOneWidget);
    expect(find.text('Beranda'), findsOneWidget);

    await tester.tap(find.text('Riwayat (0)'));
    await tester.pump();

    expect(find.text('Belum ada riwayat kuis'), findsOneWidget);
  });

  testWidgets('finishing a quiz records a result in history', (tester) async {
    await tester.pumpWidget(const MyApp());
    await login(tester);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pengetahuan Umum'));
    await tester.pumpAndSettle();

    const correctAnswers = [
      'Tokyo',
      'Asia',
      'Mars',
      'Pasifik',
      'Soekarno dan Mohammad Hatta',
    ];
    for (var questionIndex = 0; questionIndex < 5; questionIndex++) {
      await tester.tap(find.text(correctAnswers[questionIndex]));
      await tester.pump();
      await tester.tap(find.text(questionIndex == 4 ? 'Selesai' : 'Lanjut'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Luar biasa!'), findsOneWidget);
    expect(find.text('5 benar dari 5 soal'), findsOneWidget);
    await tester.tap(find.text('Ke Beranda'));
    await tester.pumpAndSettle();
    expect(find.text('Riwayat (1)'), findsOneWidget);

    await tester.tap(find.text('Riwayat (1)'));
    await tester.pumpAndSettle();
    expect(find.text('Pengetahuan Umum'), findsOneWidget);
    expect(find.text('100%'), findsOneWidget);
  });
}
