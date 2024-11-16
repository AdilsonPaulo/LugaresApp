// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_final_fields

import 'package:f05_lugares_app/components/drawer.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/model/lugares_cadastrados.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:f05_lugares_app/model/paises_cadastrados.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f05_lugares_app/components/multi_selection.dart';

class RegistrarLugar extends StatefulWidget {
  const RegistrarLugar({super.key});

  @override
  State<RegistrarLugar> createState() => _RegistrarLugarState();
}

class _RegistrarLugarState extends State<RegistrarLugar> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _UrlController = TextEditingController();
  TextEditingController _recomendacoesController = TextEditingController();
  double avaliacao = 0.0;
  double custoMedio = 0.0;
  List<Pais> _paisesSelecionados = [];
  List<String> _idPaises = [];
  List<String> _recomendacoes = [];

  static String generateId(int lastId) {
    lastId++;
    return 'p$lastId';
  }

  bool isUrlValida(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        uri.hasAbsolutePath &&
        (uri.isScheme('http') || uri.isScheme('https'));
  }

  bool _verificarLugar(
    int sizeLista,
    List<String> paises,
    String titulo,
    String imagemUrl,
    List<String> recomendacoes,
    double avaliacao,
    double custoMedio,
  ) {
    if (paises.isEmpty ||
        titulo.isEmpty ||
        isUrlValida(imagemUrl) == false ||
        recomendacoes.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void _showDialogSearchCountries(List<Pais> paises) async {
    final List<Pais>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelection(
            items: paises,
            selectedItems: _paisesSelecionados,
          );
        });

    if (results != null) {
      for (Pais p in results) {
        _idPaises.add(p.id);
      }
      setState(() {
        _paisesSelecionados = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lugaresCadastrados = Provider.of<LugaresCadastrados>(context);
    final paisesCadastrados = Provider.of<PaisesCadastrados>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro: Lugar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeData().primaryColor,
      ),
      drawer: MeuDrawer(),
      body: Center(
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                      child: TextField(
                        controller: _UrlController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText: "Url",
                            filled: true,
                            fillColor: Colors.purple.shade50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: _recomendacoesController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Recomendações",
                                  filled: true,
                                  fillColor: Colors.purple.shade50),
                            ),
                          ),
                          Expanded(
                            child: IconButton(onPressed: (){
                              _recomendacoes.add(_recomendacoesController.text);
                              _recomendacoesController.clear();
                            }, icon: Icon((Icons.add_circle), color: Theme.of(context).primaryColor,),),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            readOnly: true,
                            onTap: () {
                              _showDialogSearchCountries(
                                  paisesCadastrados.paisesCadastrados);
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                              hintText: "Escolher países",
                              filled: true,
                              fillColor: Colors.purple.shade50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Wrap(
                            spacing: 8.0,
                            children: _paisesSelecionados
                                .map((p) => Chip(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      label: Text(
                                        p.titulo,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            "Avaliação: ${avaliacao.toStringAsFixed(1)}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      value: avaliacao,
                      min: 0.0,
                      max: 5.0,
                      divisions: 50,
                      label: avaliacao.toStringAsFixed(1),
                      onChanged: (double newValue) {
                        setState(() {
                          avaliacao = newValue;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            "Custo Médio: ${custoMedio.toStringAsFixed(1)}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      value: custoMedio,
                      min: 0.0,
                      max: 100.0,
                      divisions: 100,
                      label: custoMedio.toStringAsFixed(1),
                      onChanged: (double newValue) {
                        setState(() {
                          custoMedio = newValue;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_verificarLugar(
                                lugaresCadastrados.lugaresCadastrados.length,
                                _idPaises,
                                _tituloController.text,
                                _UrlController.text,
                                _recomendacoes,
                                avaliacao,
                                custoMedio)) {
                              Lugar lugar = Lugar(
                                id: generateId(lugaresCadastrados
                                    .lugaresCadastrados.length),
                                paises: _idPaises,
                                titulo: _tituloController.text,
                                imagemUrl: _UrlController.text,
                                recomendacoes: _recomendacoes,
                                avaliacao: avaliacao,
                                custoMedio: custoMedio,
                              );
                              lugaresCadastrados.addLugar(lugar);
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/',
                                  arguments: 'Lugar adicionado com sucesso!');
                            } else {
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
                            "Cadastrar lugar",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
