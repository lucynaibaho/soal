import 'package:flutter/material.dart';

import 'quiz_question.dart';

class CategoryModel {
  const CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
    required this.questions,
  });

  final String name;
  final IconData icon;
  final Color color;
  final List<QuizQuestion> questions;

  static const List<CategoryModel> all = [
    CategoryModel(
      name: 'Pengetahuan Umum',
      icon: Icons.public,
      color: Color(0xFF176B66),
      questions: [
        QuizQuestion(
          text: 'Apa ibu kota negara Jepang?',
          options: ['Seoul', 'Tokyo', 'Beijing', 'Bangkok'],
          correctAnswer: 1,
          explanation:
              'Tokyo adalah ibu kota sekaligus kota terbesar di Jepang.',
        ),
        QuizQuestion(
          text: 'Benua terbesar di dunia adalah ...',
          options: ['Afrika', 'Eropa', 'Asia', 'Amerika Selatan'],
          correctAnswer: 2,
          explanation: 'Asia merupakan benua terbesar berdasarkan luas wilayah dan jumlah penduduk.',
        ),
        QuizQuestion(
          text: 'Planet yang dijuluki Planet Merah ialah ...',
          options: ['Venus', 'Mars', 'Jupiter', 'Merkurius'],
          correctAnswer: 1,
          explanation: 'Permukaan Mars tampak kemerahan karena banyak mengandung oksida besi.',
        ),
        QuizQuestion(
          text: 'Samudra terluas di bumi adalah ...',
          options: ['Atlantik', 'Hindia', 'Arktik', 'Pasifik'],
          correctAnswer: 3,
          explanation: 'Samudra Pasifik adalah samudra terluas di bumi.',
        ),
        QuizQuestion(
          text: 'Siapa yang dikenal sebagai Bapak Proklamator Indonesia?',
          options: [
            'Soekarno dan Mohammad Hatta',
            'Ki Hajar Dewantara',
            'Jenderal Sudirman',
            'B.J. Habibie',
          ],
          correctAnswer: 0,
          explanation: 'Soekarno dan Mohammad Hatta memproklamasikan kemerdekaan Indonesia.',
        ),
      ],
    ),
    CategoryModel(
      name: 'Sains',
      icon: Icons.science_outlined,
      color: Color(0xFF3974A5),
      questions: [
        QuizQuestion(
          text: 'Apa rumus kimia air?',
          options: ['CO2', 'O2', 'H2O', 'NaCl'],
          correctAnswer: 2,
          explanation: 'Satu molekul air tersusun dari dua atom hidrogen dan satu atom oksigen.',
        ),
        QuizQuestion(
          text: 'Organ tubuh yang memompa darah adalah ...',
          options: ['Paru-paru', 'Jantung', 'Hati', 'Ginjal'],
          correctAnswer: 1,
          explanation:
              'Jantung memompa darah ke paru-paru dan ke seluruh tubuh.',
        ),
        QuizQuestion(
          text: 'Gas yang paling banyak menyusun atmosfer bumi adalah ...',
          options: ['Oksigen', 'Karbon dioksida', 'Nitrogen', 'Hidrogen'],
          correctAnswer: 2,
          explanation: 'Sekitar 78% atmosfer bumi terdiri dari nitrogen.',
        ),
        QuizQuestion(
          text: 'Proses tumbuhan membuat makanan dengan bantuan cahaya disebut ...',
          options: ['Evaporasi', 'Fotosintesis', 'Respirasi', 'Fermentasi'],
          correctAnswer: 1,
          explanation: 'Fotosintesis mengubah air dan karbon dioksida menjadi glukosa dengan energi cahaya.',
        ),
        QuizQuestion(
          text: 'Satuan gaya dalam SI adalah ...',
          options: ['Joule', 'Watt', 'Pascal', 'Newton'],
          correctAnswer: 3,
          explanation:
              'Gaya diukur dalam newton, dinamai dari ilmuwan Isaac Newton.',
        ),
      ],
    ),
    CategoryModel(
      name: 'Matematika',
      icon: Icons.calculate_outlined,
      color: Color(0xFFB25B36),
      questions: [
        QuizQuestion(
          text: 'Berapakah hasil dari 12 × 8?',
          options: ['86', '96', '98', '108'],
          correctAnswer: 1,
          explanation: '12 dikali 8 sama dengan 96.',
        ),
        QuizQuestion(
          text: 'Berapakah nilai 15% dari 200?',
          options: ['20', '25', '30', '35'],
          correctAnswer: 2,
          explanation: '15% dari 200 adalah 0,15 × 200 = 30.',
        ),
        QuizQuestion(
          text: 'Keliling persegi dengan sisi 7 cm adalah ...',
          options: ['14 cm', '21 cm', '28 cm', '49 cm'],
          correctAnswer: 2,
          explanation: 'Keliling persegi adalah 4 × sisi, yaitu 4 × 7 = 28 cm.',
        ),
        QuizQuestion(
          text: 'Bilangan prima terkecil adalah ...',
          options: ['0', '1', '2', '3'],
          correctAnswer: 2,
          explanation: 'Bilangan 2 adalah bilangan prima terkecil dan satu-satunya bilangan prima genap.',
        ),
        QuizQuestion(
          text: 'Berapakah hasil dari 144 ÷ 12?',
          options: ['10', '11', '12', '14'],
          correctAnswer: 2,
          explanation: '144 dibagi 12 sama dengan 12.',
        ),
      ],
    ),
    CategoryModel(
      name: 'Bahasa Indonesia',
      icon: Icons.menu_book_outlined,
      color: Color(0xFF9B5271),
      questions: [
        QuizQuestion(
          text: 'Sinonim kata "cermat" adalah ...',
          options: ['Teliti', 'Lalai', 'Lambat', 'Ragu'],
          correctAnswer: 0,
          explanation: 'Cermat memiliki makna teliti atau penuh perhatian.',
        ),
        QuizQuestion(
          text: 'Lawan kata "optimis" adalah ...',
          options: ['Semangat', 'Pesimis', 'Berani', 'Yakin'],
          correctAnswer: 1,
          explanation: 'Pesimis adalah sikap yang berlawanan dengan optimis.',
        ),
        QuizQuestion(
          text: 'Kalimat yang menggunakan tanda tanya dengan tepat adalah ...',
          options: [
            'Kapan kamu pulang.',
            'Kapan kamu pulang!',
            'Kapan kamu pulang?',
            'Kapan, kamu pulang.',
          ],
          correctAnswer: 2,
          explanation: 'Kalimat tanya diakhiri dengan tanda tanya.',
        ),
        QuizQuestion(
          text: 'Kata baku yang tepat adalah ...',
          options: ['Resiko', 'Apotik', 'Aktifitas', 'Risiko'],
          correctAnswer: 3,
          explanation: 'Bentuk baku menurut KBBI adalah risiko.',
        ),
        QuizQuestion(
          text: 'Gagasan utama dalam sebuah paragraf disebut ...',
          options: [
            'Kalimat penjelas',
            'Ide pokok',
            'Kesimpulan',
            'Kata penghubung',
          ],
          correctAnswer: 1,
          explanation: 'Ide pokok adalah gagasan utama yang menjadi dasar pengembangan paragraf.',
        ),
      ],
    ),
  ];
}
