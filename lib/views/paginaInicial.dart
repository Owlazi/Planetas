import 'package:flutter/material.dart';
import '../controllers/planet_controller.dart';
import '../models/planet.dart';
import 'planet_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PlanetController _controller = PlanetController();
  List<Planet> planets = [];

  @override
  void initState() {
    super.initState();
    _loadPlanets();
  }

  Future<void> _loadPlanets() async {
    List<Planet> loadedPlanets = await _controller.getPlanets();
    setState(() {
      planets = loadedPlanets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planetas')),
      body: ListView.builder(
        itemCount: planets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(planets[index].name),
            subtitle: Text(planets[index].nickname ?? 'Sem apelido'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => PlanetDetailScreen(planet: planets[index]),
                ),
              ).then((_) => _loadPlanets());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlanetDetailScreen()),
          ).then((_) => _loadPlanets());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
