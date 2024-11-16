// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_final_fields
import 'package:f05_lugares_app/components/drawer.dart';
import 'package:flutter/material.dart';

class ConfigracoesScreen extends StatelessWidget {
  const ConfigracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configurações",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeData().primaryColor,
      ),
      drawer: MeuDrawer(),
      body: Center(
        child: Text(
          "Configurações",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
