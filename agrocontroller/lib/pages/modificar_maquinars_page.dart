import 'package:flutter/material.dart';
import '../models/maquinaria_model.dart';

class ModificarMaquinariasPage extends StatefulWidget {
  final Maquinaria maquinaria;

  const ModificarMaquinariasPage({super.key, required this.maquinaria});

  @override
  State<ModificarMaquinariasPage> createState() =>
      _ModificarMaquinariasPageState();
}

class _ModificarMaquinariasPageState extends State<ModificarMaquinariasPage> {
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController statusController;

  @override
  void initState() {
    super.initState();

    brandController = TextEditingController(text: widget.maquinaria.brand);
    modelController = TextEditingController(text: widget.maquinaria.model);
    statusController = TextEditingController(text: widget.maquinaria.status);
  }

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modificar Maquinaria ${widget.maquinaria.code}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: brandController,
              decoration: const InputDecoration(labelText: 'Marca'),
            ),
            TextField(
              controller: modelController,
              decoration: const InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.maquinaria.brand = brandController.text;
                  widget.maquinaria.model = modelController.text;
                  widget.maquinaria.status = statusController.text;
                });
                Navigator.pop(context, widget.maquinaria);
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
