import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Виджет для нижней панели навигации
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Элементы навигационной панели
      items: const [
        BottomNavigationBarItem(
          label: "Викторина",
          icon: Icon(
            FontAwesomeIcons.graduationCap,
            size: 20,
          ),
        ),
        BottomNavigationBarItem(
          label: "Справочник",
          icon: Icon(
            FontAwesomeIcons.bolt,
            size: 20,
          ),
        ),
        BottomNavigationBarItem(
          label: "Профиль",
          icon: Icon(
            FontAwesomeIcons.circleUser,
            size: 20,
          ),
        ),
      ],
      // Цвет выделенного элемента
      fixedColor: Color(0xFF1AACBC),
      // Обработка нажатий на элементы панели
      onTap: (value) {
        switch (value) {
          case 0:
          // Переход на экран Викторины (пока не задан)
            break;
          case 1:
          // Переход на экран Справочника
            Navigator.pushNamed(context, '/about');
            break;
          case 2:
          // Переход на экран Профиля
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
