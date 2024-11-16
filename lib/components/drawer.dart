import 'package:flutter/material.dart';

class MeuDrawer extends StatelessWidget {
  const MeuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ThemeData().primaryColor,
            ),
            child: Text(
              'Configurações',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.bookmark_add),
            title: const Text('Novo país'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                '/cadastrarpais',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_location_sharp),
            title: const Text('Novo lugar'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(
                '/cadastrarlugar',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: const Text('Países'),
            onTap: () {
              //context.pushReplacement('/');
              Navigator.of(context).pushReplacementNamed(
                '/',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: const Text('Lugares'),
            onTap: () {
              //context.pushReplacement('/');
              Navigator.of(context).pushReplacementNamed(
                '/lugares',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.engineering),
            title: const Text('Configurações'),
            onTap: () {
              //context.pushReplacement('/configuracoes');
              Navigator.of(context).pushReplacementNamed(
                '/configuracoes',
              );
            },
          ),
        ],
      ),
    );
  }
}
