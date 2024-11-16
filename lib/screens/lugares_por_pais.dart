// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_final_fields
import 'package:f05_lugares_app/components/item_lugar.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/model/lugares_cadastrados.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LugarPorPaisScreen extends StatelessWidget {

  LugarPorPaisScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final pais = ModalRoute.of(context)?.settings.arguments as Pais;
    
    final lugares = Provider.of<LugaresCadastrados>(context);

    final List<Lugar> lugaresPorPais = lugares.lugaresCadastrados.where((lugar){
      return lugar.paises.contains(pais.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
         backgroundColor: pais.cor,
        title: Text(
          "Lugares em ${pais.titulo}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: lugaresPorPais.length,
        itemBuilder: (context, index) {
          return ItemLugar(lugar: lugaresPorPais.elementAt(index));
        },
      ),
    );
  }
}
