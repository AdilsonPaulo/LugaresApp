// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_final_fields
import 'package:f05_lugares_app/components/drawer.dart';
import 'package:f05_lugares_app/components/item_lugar.dart';
import 'package:f05_lugares_app/model/lugar.dart';
import 'package:f05_lugares_app/model/lugares_cadastrados.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LugaresGeral extends StatelessWidget {
  const LugaresGeral({super.key});

  @override
  Widget build(BuildContext context) {
    final lugares = Provider.of<LugaresCadastrados>(context);

    return Scaffold(
      appBar: AppBar(
         backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Lugares Cadastrados",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MeuDrawer(),
      floatingActionButton: FloatingActionButton(onPressed: (){Navigator.pushNamed(context, "/cadastrarlugar");}, child: Icon(Icons.add),),
      body: ListView.builder(
        itemCount: lugares.lugaresCadastrados.length,
        itemBuilder: (context, index) {
          return Dismissible(
          key: Key(lugares.lugaresCadastrados[index].titulo),
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
                        lugares.removeLugar(lugares.lugaresCadastrados[index]);
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
          child: ItemLugar(lugar: lugares.lugaresCadastrados[index]));
        },
      ),
    );
  }
}
