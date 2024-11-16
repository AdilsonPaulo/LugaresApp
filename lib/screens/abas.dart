// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_final_fields

import 'package:f05_lugares_app/components/drawer.dart';
import 'package:f05_lugares_app/screens/favoritos.dart';
import 'package:f05_lugares_app/screens/pais_screen.dart';
import 'package:flutter/material.dart';

class MinhasAbasBottom extends StatefulWidget {
  MinhasAbasBottom({super.key});

  @override
  State<MinhasAbasBottom> createState() => _MinhasAbasBottomState();
}

class _MinhasAbasBottomState extends State<MinhasAbasBottom> {
  String _nomeTab = "Países";
  List<String> _nomeTabs = ["Países", "Favoritos"];

  void _getNomeTab(int index) {
    setState(() {
      _nomeTab = _nomeTabs[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? mensagem =
        ModalRoute.of(context)?.settings.arguments as String?;
    
    if (mensagem != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mensagem)),
        );
      });
    }

    
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "${_nomeTab.toString()}",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: ThemeData().primaryColor,
            ),
            drawer: MeuDrawer(),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    children: [
                      PaisScreen(),
                      FavoritosScreen(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  decoration: BoxDecoration(
                    color: ThemeData().primaryColor,
                  ),
                  child: TabBar(
                      onTap: (index) {
                        _getNomeTab(index);
                      },
                      indicatorColor: Colors.amber,
                      labelColor: Colors.amber,
                      unselectedLabelColor: Colors.white60,
                      tabs: const [
                        Tab(
                          icon: Icon(
                            Icons.category,
                          ),
                          text: "Países",
                        ),
                        Tab(
                          icon: Icon(
                            Icons.star,
                          ),
                          text: "Favoritos",
                        )
                      ]),
                )
              ],
            )));
  }
}
