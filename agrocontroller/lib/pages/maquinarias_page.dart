import 'package:agrocontroller/pages/modificar_maquinars_page.dart';
import 'package:agrocontroller/providers/maquinarias_provider.dart';
import 'package:flutter/material.dart';
import '../models/maquinaria_model.dart';

class MaquinariasPage extends StatefulWidget {
  const MaquinariasPage({super.key});

  @override
  State<MaquinariasPage> createState() => _MaquinariasPageState();
}

class _MaquinariasPageState extends State<MaquinariasPage> {
  int page = 1;
  int pageSize = 10;
  String search = '';
  List<Maquinaria> maquinarias = [];

  @override
  void initState() {
    super.initState();
    fetchMaquinarias();
  }

  Future<void> fetchMaquinarias() async {
    var response =
        await MaquinariasProvider().fetchMaquinarias(page, pageSize, search);
    setState(() {
      maquinarias = (response['data'] as List)
          .map((json) => Maquinaria.fromJson(json))
          .toList();
    });
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text(
              '¿Estás seguro de que deseas eliminar esta maquinaria?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                removeMaquinaria(index);
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void removeMaquinaria(int index) {
    setState(() {
      maquinarias.removeAt(index);
    });
  }

  Future<void> _navigateAndModify(
      BuildContext context, Maquinaria maquinaria, int index) async {
    var updatedMaquinaria = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModificarMaquinariasPage(
          maquinaria: maquinaria,
        ),
      ),
    );

    if (updatedMaquinaria != null) {
      setState(() {
        maquinarias[index] = updatedMaquinaria;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('AgroController')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                  fetchMaquinarias();
                },
                decoration: const InputDecoration(
                  hintText: 'Buscar maquinaria...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: maquinarias.length,
                itemBuilder: (context, index) {
                  var maquinaria = maquinarias[index];
                  return ListTile(
                    leading: const Icon(Icons.agriculture),
                    title: Text(maquinaria.code),
                    subtitle: Text('${maquinaria.brand} - ${maquinaria.model}'),
                    onLongPress: () =>
                        _navigateAndModify(context, maquinaria, index),
                    onTap: () {
                      showDeleteConfirmationDialog(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
