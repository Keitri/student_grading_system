import 'package:flutter/material.dart';

Widget get space => const SizedBox(height: 10);

Color _gradeColor(double grade) {
  if (grade > 80) {
    return Colors.green;
  }

  if (grade < 80 && grade > 75) {
    return Colors.orangeAccent;
  }

  return Colors.red;
}

Widget totalGradeWidget(double totalGrade) {
  return Container(
    width: 60,
    height: 60,
    decoration:
        BoxDecoration(color: _gradeColor(totalGrade), shape: BoxShape.circle),
    child: Center(
        child: Text(
      totalGrade.toStringAsFixed(2),
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    )),
  );
}
