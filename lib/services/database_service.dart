import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final String databaseName = "know_karelia.db";

  // Открытие соединения с базой данных
  static Future<Database> openDatabaseConnection() async {
    // Определение пути к базе данных
    String databasePath = join(await getDatabasesPath(), databaseName);

    // Проверка существования базы данных
    // if (await databaseExists(databasePath)) {
    //   print("База данных уже существует");
    // } else {
      // Загрузка базы данных из assets
      ByteData data = await rootBundle.load("db/$databaseName");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Копирование базы данных в нужное место
      await File(databasePath).writeAsBytes(bytes, flush: true);
      print("База данных скопирована из assets");
    // }

    // Открытие базы данных
    return openDatabase(databasePath);
  }
}
