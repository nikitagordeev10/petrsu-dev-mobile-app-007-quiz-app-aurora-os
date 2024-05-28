import 'package:flutter/material.dart';
import 'package:know_karelia/services/exhibits.dart';

// Экран с результатами викторины
class ResultsPage extends StatefulWidget {
  final List<Exhibit> questions; // Список вопросов
  final List<bool> trueFalseAll; // Список правильных/неправильных ответов
  final int trueNumber; // Количество правильных ответов
  final int falseNumber; // Количество неправильных ответов
  final String difficulty; // Уровень сложности викторины

  ResultsPage(this.questions, this.trueFalseAll, this.trueNumber, this.falseNumber, this.difficulty, {Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  // Проверка, больше ли правильных ответов, чем неправильных
  bool successControl() {
    return widget.trueNumber > widget.falseNumber;
  }

  // Создание виджета с текстом результата
  Widget buildResultText() {
    return Center(
      child: Text(
        successControl() ? "Отличный результат!" : "Нужно подтянуть знания!",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: successControl() ? Colors.green : Colors.red,
          fontSize: 32,
          fontFamily: "Ubuntu",
        ),
      ),
    );
  }

  // Создание карточки с количеством правильных/неправильных ответов
  Widget buildScoreCard(String title, int score, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 3),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: Color(0xFF1AACBC),
          width: 2.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 165,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontFamily: "Ubuntu",
              ),
            ),
          ),
          Container(
            width: 165,
            child: Text(
              "$score",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: "Ubuntu",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Создание списка вопросов и ответов
  Widget buildQuestionList() {
    return Container(
      width: 400,
      height: 360,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 3),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: Color(0xFF1AACBC),
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListView.builder(
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            var flag = widget.questions[index];
            return Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: widget.trueFalseAll[index] ? Colors.green : Colors.red,
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        widget.trueFalseAll[index] ? Icons.check : Icons.close,
                        size: 30,
                        color: widget.trueFalseAll[index] ? Colors.green : Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "${index + 1}.",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          fontFamily: "Ubuntu",
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Text(
                      "${flag.exhibitName}",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        fontFamily: "Ubuntu",
                        color: Colors.black54,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 75,
                        child: Image.asset(
                          "images/${widget.difficulty.toLowerCase()}/${flag.exhibitImage}",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Создание кнопки возврата на главный экран
  Widget buildBackButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: 350,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Color(0xFF1AACBC),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0, 3),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            "Вернутся на главный экран",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Ubuntu",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                children: [
                  buildResultText(), // Виджет с текстом результата
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildScoreCard("Правильных ответов:", widget.trueNumber, Colors.green), // Карточка правильных ответов
                        buildScoreCard("Неправильных ответов:", widget.falseNumber, Colors.red), // Карточка неправильных ответов
                      ],
                    ),
                  ),
                  buildQuestionList(), // Список вопросов и ответов
                  buildBackButton(), // Кнопка возврата на главный экран
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
