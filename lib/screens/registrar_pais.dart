// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_final_fields
import 'package:f05_lugares_app/components/drawer.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:f05_lugares_app/model/paises_cadastrados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class RegistrarPais extends StatefulWidget {
  const RegistrarPais({super.key});

  @override
  State<RegistrarPais> createState() => _RegistrarPaisState();
}

class _RegistrarPaisState extends State<RegistrarPais> {
  Color _selectedColor = Colors.white;
  TextEditingController _tituloController = TextEditingController();

  static String generateId(int lastId) {
    lastId++;
    return 'c$lastId';
  }

  bool _verificarPais(int tamanho, String titulo, Color color) {
    if (titulo.isEmpty) {
      return false;
    }
    return true;
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Escolha uma cor'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Colors.blue,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final paisesCadastrados = Provider.of<PaisesCadastrados>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro: Pais",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeData().primaryColor,
      ),
      drawer: MeuDrawer(),
      body: Container(
        height: double.infinity,
        color: _selectedColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _tituloController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Título",
                        filled: true,
                        fillColor: Colors.purple.shade50),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            _showColorPicker();
                          },
                          child: Image.asset("assets/colorpicker.png"))),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_verificarPais(
                            paisesCadastrados.paisesCadastrados.length,
                            _tituloController.text,
                            _selectedColor)) {
                          Pais p = Pais(
                              id: generateId(
                                  paisesCadastrados.paisesCadastrados.length),
                              titulo: _tituloController.text,
                              cor: _selectedColor);
                              paisesCadastrados.addPais(p);
                              Navigator.pop(context);
                        Navigator.pushNamed(context, '/',
                            arguments: 'Pais adicionado com sucesso!');
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Erro nos campos digitados")),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 60),
                          backgroundColor: ThemeData().primaryColor,
                          foregroundColor: Colors.white),
                      child: Text(
                        "Cadastrar País",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
