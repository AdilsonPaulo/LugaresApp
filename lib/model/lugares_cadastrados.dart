import 'package:f05_lugares_app/data/dados.dart';
import 'package:flutter/material.dart';
import 'package:f05_lugares_app/model/lugar.dart';

class LugaresCadastrados with ChangeNotifier{

  List<Lugar> _lugaresCadastrados = [];

  List<Lugar> get lugaresCadastrados => _lugaresCadastrados;

  LugaresCadastrados(){
    _lugaresCadastrados = List.from(lugares);
  }

  void addLugar(Lugar lugar){
    _lugaresCadastrados.add(lugar);
    notifyListeners();
  }

  void removeLugar(Lugar lugar){
    _lugaresCadastrados.remove(lugar);
  }

  bool temNaLista(Lugar lugar){
    return _lugaresCadastrados.contains(lugar);
  }
}