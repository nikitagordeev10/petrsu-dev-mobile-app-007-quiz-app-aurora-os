import 'package:flutter/material.dart';

// Виджет для сообщения об ошибке
class ErrorMessage extends StatelessWidget {
  final String message;

  // Конструктор с сообщением по умолчанию
  const ErrorMessage({super.key, this.message = 'Ошибка'});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Центрирование текста
      child: Text(
        message,
        // Стиль текста
        style: TextStyle(
          color: Colors.red, // Красный цвет текста
          fontSize: 18, // Размер шрифта
          fontWeight: FontWeight.bold, // Жирный шрифт
        ),
      ),
    );
  }
}
