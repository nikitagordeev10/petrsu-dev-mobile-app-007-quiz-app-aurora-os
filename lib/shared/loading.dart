import 'package:flutter/material.dart';

// Виджет, отображающий индикатор загрузки
class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 250,
      height: 250,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ), // Индикатор загрузки внутри контейнера
    );
  }
}

// Экран загрузки
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Loader(), // Отображаем индикатор загрузки по центру
      ),
    );
  }
}
