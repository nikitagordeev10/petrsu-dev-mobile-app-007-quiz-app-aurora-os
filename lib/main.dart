// Импортируем необходимые библиотеки и модули для Flutter приложения
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:know_karelia/topics/topics_page.dart';
import 'package:know_karelia/services/routes.dart';

// Определяем глобальную тему для приложения
var appTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Ubuntu',
);

// Главная функция, которая запускает приложение
void main() {
  runApp(MyApp());
}

// Основной виджет приложения, который является неизменяемым
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes, // Устанавливаем маршруты для навигации
      theme: appTheme, // Применяем тему к приложению
      home: const LoadingScreen(), // Указываем начальный экран
    );
  }
}

// Виджет экрана загрузки, который отображается при запуске приложения
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginPage(), // Центрируем виджет страницы входа
      ),
    );
  }
}

// Виджет страницы входа
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Вход",
          textAlign: TextAlign.center,
        ),
        centerTitle: true, // Центрируем заголовок
      ),
      body: Container(
        padding: EdgeInsets.all(30), // Устанавливаем отступы
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Равномерно распределяем элементы по вертикали
          children: [
            Image.asset(
              'assets/icon/icon_square.png', // Логотип приложения
              width: 150,
              height: 150,
            ),
            Text(
              'Узнай Карелию',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: "Продолжить как гость",
                loginMethod: () {
                  // Навигация на страницу с темами при нажатии кнопки
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TopicPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет кнопки для входа
class LoginButton extends StatelessWidget {
  final IconData icon; // Иконка на кнопке
  final String text; // Текст кнопки
  final Function loginMethod; // Метод, который вызывается при нажатии кнопки

  const LoginButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.loginMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () => loginMethod(), // Вызываем метод при нажатии
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: Color(0xFF1AACBC), // Устанавливаем цвет кнопки
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(double.infinity, 60), // Устанавливаем минимальный размер кнопки
        ),
        label: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
