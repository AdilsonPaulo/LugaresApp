// ignore_for_file: prefer_const_constructors

import 'package:f05_lugares_app/components/item_pais.dart';
import 'package:f05_lugares_app/model/paises_cadastrados.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaisScreen extends StatelessWidget {
  const PaisScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final paises = Provider.of<PaisesCadastrados>(context);
    
    if (paises.paisesCadastrados.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum País cadastrado!',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.pushNamed(context, "/cadastrarpais");}, child: Icon(Icons.add),),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 120,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
        ),
        itemCount: paises.paisesCadastrados.length,
        itemBuilder: (BuildContext context, int index) { 
          return Dismissible(
          key: Key(paises.paisesCadastrados[index].titulo),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            final result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Excluir país da lista?"),
                  content: Text("Tem certeza que deseja excluir este país?"),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Confirmar"),
                      onPressed: () {
                        paises.removePais(paises.paisesCadastrados[index]);
                        Navigator.of(context).pop(true);
                      },
                    ),
                    TextButton(
                      child: Text("Cancelar"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ],
                );
              },
            );
            return result ?? false;
          },
          child: ItemPais(pais: paises.paisesCadastrados[index]));
         },
      ),
    );
  }
}
