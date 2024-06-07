// Импортируем необходимые библиотеки и модули для Flutter приложения
import 'package:know_karelia/quiz/quiz_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:know_karelia/shared/bottom_navigation_bar.dart';
import 'package:know_karelia/services/routes.dart';

// Определяем StatefulWidget для страницы тем
class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

// Определяем состояние для страницы тем
class _TopicPageState extends State<TopicPage> {
  double difficultyLevel = 2.0; // Значение уровня сложности по умолчанию
  var difficultyOptions = ["Easy", "Medium", "Hard"]; // Список уровней сложности
  String selectedDifficulty = "Medium"; // Выбранный уровень сложности по умолчанию
  double numberOfQuestions = 5.0; // Количество вопросов по умолчанию
  double secondsPerQuestion = 10.0; // Время на вопрос по умолчанию
  bool isTimerEnabled = true; // Состояние переключателя времени

  @override
  Widget build(BuildContext context) {
    // Получаем информацию о дисплее
    var displayInfo = MediaQuery.of(context);
    final double screenHeight = displayInfo.size.height;
    final double screenWidth = displayInfo.size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Викторина",
          textAlign: TextAlign.center, // Выравнивание текста по центру внутри AppBar
        ),
        centerTitle: true, // Устанавливаем центрирование заголовка
      ),

      // Подключаем нижнюю навигационную панель
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: [
          // Основной контейнер для установки размеров
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SafeArea(
            // Центрируем содержимое
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight / 15, left: 13, right: 13),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Container(
                      // Декорируем контейнер с параметрами викторины
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.transparent, // Прозрачная тень
                            offset: Offset(0, 4),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent, // Прозрачный фон
                      ),
                      child: Column(
                        children: [
                          // Отображаем текущий уровень сложности
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Уровень сложности = $selectedDifficulty",
                              style: TextStyle(
                                color: Colors.white, // Белый цвет текста
                                fontSize: screenWidth / 20,
                                fontFamily: "Ubuntu",
                              ),
                            ),
                          ),
                          // Слайдер для выбора уровня сложности
                          Slider(
                            max: 3.0,
                            min: 1.0,
                            value: difficultyLevel,
                            activeColor: Color(0xff1AACBC),
                            inactiveColor: Colors.grey,
                            onChanged: (double value) {
                              setState(() {
                                difficultyLevel = value.ceilToDouble();
                                selectedDifficulty = difficultyOptions[difficultyLevel.toInt() - 1];
                              });
                            },
                          ),
                          // Отображаем текущее количество вопросов
                          Text(
                            "Количество вопросов = ${numberOfQuestions.toInt()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth / 20,
                              fontFamily: "Ubuntu",
                            ),
                          ),
                          // Слайдер для выбора количества вопросов
                          Slider(
                            max: 7.0,
                            min: 3.0,
                            value: numberOfQuestions,
                            activeColor: Color(0xff1AACBC),
                            inactiveColor: Colors.grey,
                            onChanged: (double value) {
                              setState(() {
                                numberOfQuestions = value.ceilToDouble();
                              });
                            },
                          ),
                          // Условное отображение времени на вопрос
                          Visibility(
                            visible: isTimerEnabled,
                            child: Text(
                              "Секунд на вопрос = ${secondsPerQuestion.toInt()}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth / 20,
                                fontFamily: "Ubuntu",
                              ),
                            ),
                          ),
                          // Слайдер для выбора времени на вопрос
                          Visibility(
                            visible: isTimerEnabled,
                            child: Slider(
                              max: 13.0,
                              min: 7.0,
                              value: secondsPerQuestion,
                              activeColor: Color(0xff1AACBC),
                              inactiveColor: Colors.grey,
                              onChanged: (double value) {
                                setState(() {
                                  secondsPerQuestion = value.ceilToDouble();
                                });
                              },
                            ),
                          ),
                          // Подпись для переключателя времени
                          Text(
                            "Время",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth / 20,
                              fontFamily: "Ubuntu",
                            ),
                          ),
                          // Переключатель времени
                          Switch(
                            value: isTimerEnabled,
                            activeColor: Color(0xff1AACBC),
                            activeTrackColor: Color(0xffFFFFFF),
                            inactiveThumbColor: Colors.black54,
                            inactiveTrackColor: Colors.grey.shade400,
                            onChanged: (bool value) {
                              setState(() {
                                isTimerEnabled = value;
                              });
                            },
                          ),
                          // Кнопка для начала игры
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Game(
                                    numberOfQuestions,
                                    selectedDifficulty,
                                    secondsPerQuestion.toInt(),
                                    isTimerEnabled,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xff1AACBC), // Цвет кнопки
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    "Начать",
                                    style: TextStyle(
                                      fontSize: screenWidth / 20,
                                      fontFamily: "Ubuntu",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
