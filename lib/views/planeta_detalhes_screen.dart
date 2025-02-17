import 'package:flutter/material.dart';
import '../models/planet.dart';
import '../controllers/planet_controller.dart';

class PlanetDetailScreen extends StatefulWidget {
  final Planet? planet;

  PlanetDetailScreen({this.planet});

  @override
  _PlanetDetailScreenState createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _distanceController = TextEditingController();
  final _sizeController = TextEditingController();
  final _nicknameController = TextEditingController();
  final PlanetController _controller = PlanetController();

  @override
  void initState() {
    super.initState();
    if (widget.planet != null) {
      _nameController.text = widget.planet!.name;
      _distanceController.text = widget.planet!.distanceFromSun.toString();
      _sizeController.text = widget.planet!.size.toString();
      _nicknameController.text = widget.planet!.nickname ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.planet == null ? 'Adicionar Planeta' : 'Editar Planeta',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome do Planeta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do planeta';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanceController,
                decoration: InputDecoration(labelText: 'Distância do Sol (UA)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a distância do sol';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sizeController,
                decoration: InputDecoration(labelText: 'Tamanho (km)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o tamanho do planeta';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nicknameController,
                decoration: InputDecoration(labelText: 'Apelido (opcional)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Planet planet = Planet(
                      id: widget.planet?.id,
                      name: _nameController.text,
                      distanceFromSun: double.parse(_distanceController.text),
                      size: double.parse(_sizeController.text),
                      nickname:
                          _nicknameController.text.isEmpty
                              ? null
                              : _nicknameController.text,
                    );

                    if (widget.planet == null) {
                      await _controller.addPlanet(planet);
                    } else {
                      await _controller.updatePlanet(planet);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.planet == null ? 'Adicionar' : 'Atualizar'),
              ),
              if (widget.planet != null)
                ElevatedButton(
                  onPressed: () async {
                    await _controller.deletePlanet(widget.planet!.id!);
                    Navigator.pop(context);
                  },
                  child: Text('Excluir'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
