import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Профиль",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('db/avatars/user.png'),
            ),
            SizedBox(height: 20),
            Text(
              "Гость",
              style: TextStyle(fontSize: 20.0),
            ),
            Text("Адрес электронной почты не указан"),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
