import 'package:know_karelia/quiz/quiz_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:know_karelia/shared/bottom_navigation_bar.dart';
import 'package:know_karelia/routes.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key});

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  double zorluk = 2.0;
  var difficulties = ["Easy", "Medium", "Hard"];
  String difficulty = "Medium";
  double question_number = 5.0;
  double question_second = 10.0;
  bool switchbutton = true;

  @override
  Widget build(BuildContext context) {
    var display_info = MediaQuery.of(context);
    final double e_height = display_info.size.height;
    final double e_width = display_info.size.width;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0xFF1AACBC),
        title: Text(
          "Викторина",
          textAlign: TextAlign.center, // Выравнивание текста по центру внутри AppBar
        ),
        centerTitle: true, // Устанавливаем центрирование заголовка
      ),

      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(
                // image: DecorationImage(
              // image: AssetImage("images/back3.jpg"),
              // fit: BoxFit.cover,
            // )),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: e_height / 15, left: 13, right: 13),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.transparent,
                            offset: Offset(0, 4),
                            blurRadius: 2,
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.transparent, // Transparent background
                        // border: Border.all(color: Colors.black, width: 3),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Уровень сложности = ${difficulty}",
                              style: TextStyle(
                                color: Colors.white, // White text color
                                fontSize: e_width / 20,
                                fontFamily: "Ubuntu",
                              ),
                            ),
                          ),
                          Slider(
                            max: 3.0,
                            min: 1.0,
                            value: zorluk,
                            activeColor: Color(0xff1AACBC),
                            inactiveColor: Colors.grey,
                            onChanged: (double i) {
                              setState(() {
                                zorluk = i.ceilToDouble();
                                difficulty = difficulties[zorluk.toInt() - 1];
                              });
                            },
                          ),
                          Text(
                            "Количество вопросов = ${question_number.toInt()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: e_width / 20,
                              fontFamily: "Ubuntu",
                            ),
                          ),
                          Slider(
                            max: 7.0,
                            min: 3.0,
                            value: question_number,
                            activeColor: Color(0xff1AACBC),
                            inactiveColor: Colors.grey,
                            onChanged: (double i) {
                              setState(() {
                                question_number = i.ceilToDouble();
                              });
                            },
                          ),
                          Visibility(
                            visible: switchbutton,
                            child: Text(
                              "Секунд на вопрос = ${question_second.toInt()}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: e_width / 20,
                                fontFamily: "Ubuntu",
                              ),
                            ),
                          ),
                          Visibility(
                            visible: switchbutton,
                            child: Slider(
                              max: 13.0,
                              min: 7.0,
                              value: question_second,
                              activeColor: Color(0xff1AACBC),
                              inactiveColor: Colors.grey,
                              onChanged: (double i) {
                                setState(() {
                                  question_second = i.ceilToDouble();
                                });
                              },
                            ),
                          ),
                          Text(
                            "Время",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: e_width / 20,
                              fontFamily: "Ubuntu",
                            ),
                          ),
                          Switch(
                            value: switchbutton,
                            activeColor: Color(0xff1AACBC),
                            activeTrackColor: Color(0xffFFFFFF),
                            inactiveThumbColor: Colors.black54,
                            inactiveTrackColor: Colors.grey.shade400,
                            onChanged: (veri) {
                              setState(() {
                                switchbutton = veri;
                              });
                            },
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Game(question_number, difficulty, question_second.toInt(), switchbutton)));
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xff1AACBC), // Updated button color
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Text(
                                    "Начать",
                                    style: TextStyle(
                                      fontSize: e_width / 20,
                                      fontFamily: "Ubuntu",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
