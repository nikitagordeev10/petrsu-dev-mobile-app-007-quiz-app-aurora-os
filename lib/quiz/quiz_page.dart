import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:know_karelia/services/exhibits.dart';
import 'package:know_karelia/services/exhibits_repository.dart';
import 'package:know_karelia/results/results_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

// Этот класс определяет виджет игры
class Game extends StatefulWidget {
  final double questionNumber; // Количество вопросов
  final String selectedDifficulty; // Сложность игры
  final int second; // Время на ответ в секундах
  final bool timeControl; // Управление временем

  Game(this.questionNumber, this.selectedDifficulty, this.second, this.timeControl, {super.key});

  @override
  State<Game> createState() => _GameState();
}

// Состояние виджета игры
class _GameState extends State<Game> {
  late Future<void> _future;
  List<Exhibit> questions = []; // Список вопросов
  List<Exhibit> wrongQuestions = []; // Список неверных ответов
  List<bool> trueFalseAll = []; // Список правильных/неправильных ответов
  late Exhibit trueQuestion; // Правильный вопрос
  var allAnswers = HashSet<Exhibit>(); // Все варианты ответов

  int questionNumber = 0; // Текущий номер вопроса
  int trueNumber = 0; // Количество правильных ответов
  int falseNumber = 0; // Количество неправильных ответов
  String exhibitImage = "placeholder.png"; // Изображение вопроса
  String buttonA = ""; // Вариант ответа А
  String buttonB = ""; // Вариант ответа В
  String buttonC = ""; // Вариант ответа С
  String buttonD = ""; // Вариант ответа D
  late int realTime; // Оставшееся время
  Timer? timer;

  @override
  void initState() {
    super.initState();
    realTime = widget.second;
    _future = getQuestions();
    if (widget.timeControl) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (realTime > 0) {
          setState(() {
            realTime--;
          });
        } else {
          handleWrongAnswer();
          nextQuestion();
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Получение вопросов
  Future<void> getQuestions() async {
    questions = await ExhibitsRepository().getRandomExhibits(
        widget.selectedDifficulty, widget.questionNumber.toInt());
    await loadQuestions();
  }

  // Загрузка вопросов
  Future<void> loadQuestions() async {
    if (questionNumber >= questions.length) return;

    realTime = widget.second;
    trueQuestion = questions[questionNumber];
    wrongQuestions = await ExhibitsRepository().getRelatedExhibits(
        widget.selectedDifficulty, trueQuestion.exhibitId);

    allAnswers
      ..clear()
      ..addAll(wrongQuestions.take(3))
      ..add(trueQuestion);
    exhibitImage = trueQuestion.exhibitImage;

    var answersList = allAnswers.toList();
    answersList.shuffle();
    buttonA = answersList[0].exhibitName;
    buttonB = answersList[1].exhibitName;
    buttonC = answersList[2].exhibitName;
    buttonD = answersList[3].exhibitName;

    setState(() {});
  }

  // Обработка ответа
  void handleAnswer(String answer) {
    setState(() {
      if (trueQuestion.exhibitName == answer) {
        trueNumber++;
        trueFalseAll.add(true);
      } else {
        falseNumber++;
        trueFalseAll.add(false);
      }
    });
    nextQuestion();
  }

  // Обработка неправильного ответа
  void handleWrongAnswer() {
    setState(() {
      falseNumber++;
      trueFalseAll.add(false);
    });
  }

  // Переход к следующему вопросу
  void nextQuestion() {
    if (questionNumber < widget.questionNumber - 1) {
      questionNumber++;
      loadQuestions();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultsPage(questions, trueFalseAll, trueNumber, falseNumber,
                  widget.selectedDifficulty),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildGameContent();
          }
        },
      ),
    );
  }

  // Виджет с содержимым игры
  Widget buildGameContent() {
    return Stack(
      children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
        ),
        SafeArea(
          child: Column(
            children: [
              buildScoreRow(),
              buildExhibitImage(),
              buildAnswerButton(buttonA),
              buildAnswerButton(buttonB),
              buildAnswerButton(buttonC),
              buildAnswerButton(buttonD),
            ],
          ),
        ),
      ],
    );
  }

  // Виджет строки результатов
  Widget buildScoreRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildScoreColumn(Icons.check, trueNumber, Colors.green.shade700),
        if (widget.timeControl)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 8.0,
              percent: (widget.second - realTime) / widget.second,
              center: Text(
                "$realTime",
                style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontSize: 35,
                  color: Color(0xFF1AACBC),
                ),
              ),
              progressColor: Color(0xFF1AACBC),
            ),
          ),
        buildScoreColumn(Icons.close, falseNumber, Colors.red.shade700),
      ],
    );
  }

  // Виджет колонки результатов
  Widget buildScoreColumn(IconData icon, int score, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Icon(icon, size: 60, color: color),
          Text(
            "$score",
            style: TextStyle(
              fontSize: 33,
              color: Colors.white,
              fontFamily: "Ubuntu",
            ),
          ),
        ],
      ),
    );
  }

  // Виджет изображения вопроса
  Widget buildExhibitImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: 2)
          ],
        ),
        child: Image.asset(
            "db/images/${widget.selectedDifficulty.toLowerCase()}/$exhibitImage"),
        height: 230,
        width: 230,
      ),
    );
  }

  // Виджет для создания кнопки ответа
  Widget buildAnswerButton(String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(0, 4), blurRadius: 4),
          ],
        ),
        child: InkWell(
          onTap: () => handleAnswer(answer),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Ubuntu",
                  color: Colors.blueGrey.shade700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}