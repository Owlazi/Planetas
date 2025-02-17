import '../models/planet.dart';
import '../database/database_helper.dart';

class PlanetController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> addPlanet(Planet planet) async {
    return await _databaseHelper.insertPlanet(planet);
  }

  Future<List<Planet>> getPlanets() async {
    return await _databaseHelper.getPlanets();
  }

  Future<int> updatePlanet(Planet planet) async {
    return await _databaseHelper.updatePlanet(planet);
  }

  Future<int> deletePlanet(int id) async {
    return await _databaseHelper.deletePlanet(id);
  }
}
