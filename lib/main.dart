// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, prefer_final_fields
import 'package:f05_lugares_app/screens/abas.dart';
import 'package:f05_lugares_app/screens/configuracoes.dart';
import 'package:f05_lugares_app/screens/detalhes_lugar.dart';
import 'package:f05_lugares_app/screens/lugares_geral.dart';
import 'package:f05_lugares_app/screens/lugares_por_pais.dart';
import 'package:f05_lugares_app/screens/registrar_lugar.dart';
import 'package:f05_lugares_app/screens/registrar_pais.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f05_lugares_app/model/lugares_cadastrados.dart';
import 'package:f05_lugares_app/model/lugares_favoritos.dart';
import 'package:f05_lugares_app/model/paises_cadastrados.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LugaresFavoritos(),
      ),
      ChangeNotifierProvider(
        create: (context) => LugaresCadastrados(),
      ),
      ChangeNotifierProvider(
        create: (context) => PaisesCadastrados(),
      ),
    ],
    child: MeuApp(),
  ));
}

//Estava tendo problemas com certificação ssl, função que ignora isso pra desenvolvimento
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
              color:
                  Colors.white), // Define a cor dos ícones do AppBar globalmente
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => MinhasAbasBottom(),
        '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
        '/detalheLugar': (ctx) => DetalhesLugarScreen(),
        '/configuracoes': (ctx) => ConfigracoesScreen(),
        '/cadastrarlugar': (ctx) => RegistrarLugar(),
        '/cadastrarpais': (ctx) => RegistrarPais(),
        '/lugares': (ctx) => LugaresGeral(),
      },
    );
  }
}
