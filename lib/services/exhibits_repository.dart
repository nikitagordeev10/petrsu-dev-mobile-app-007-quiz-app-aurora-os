import 'package:know_karelia/services/exhibits.dart'; // Импортируем класс Exhibit
import 'package:know_karelia/services/database_service.dart'; // Импортируем сервис для работы с базой данных

class ExhibitsRepository {
  // Метод для получения случайных экспонатов по заданной сложности и количеству
  Future<List<Exhibit>> getRandomExhibits(String selectedDifficulty, int number) async {
    var database = await DatabaseService.openDatabaseConnection(); // Открываем соединение с базой данных

    // Выполняем запрос к базе данных для получения случайных экспонатов
    List<Map<String, dynamic>> maps = await database.rawQuery("SELECT * FROM $selectedDifficulty ORDER BY RANDOM() LIMIT $number");

    // Преобразуем результаты запроса в список объектов Exhibit
    return List.generate(maps.length, (index) {
      var exhibitData = maps[index];
      return Exhibit(exhibitData["exhibitId"], exhibitData["exhibitName"], exhibitData["exhibitImage"]);
    });
  }

  // Метод для получения связанных экспонатов, исключая экспонат с заданным id
  Future<List<Exhibit>> getRelatedExhibits(String selectedDifficulty, int id) async {
    var database = await DatabaseService.openDatabaseConnection(); // Открываем соединение с базой данных

    // Выполняем запрос к базе данных для получения связанных экспонатов
    List<Map<String, dynamic>> maps = await database.rawQuery("SELECT * FROM $selectedDifficulty WHERE exhibitId != $id ORDER BY RANDOM() LIMIT 3");

    // Преобразуем результаты запроса в список объектов Exhibit
    return List.generate(maps.length, (index) {
      var exhibitData = maps[index];
      return Exhibit(exhibitData["exhibitId"], exhibitData["exhibitName"], exhibitData["exhibitImage"]);
    });
  }
}
