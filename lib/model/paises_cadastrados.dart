import 'package:flutter/material.dart';
import 'package:f05_lugares_app/model/pais.dart';
import 'package:f05_lugares_app/data/dados.dart';

class PaisesCadastrados with ChangeNotifier{

  List<Pais> _paisesCadastrados = [];

  List<Pais> get paisesCadastrados => _paisesCadastrados;

  PaisesCadastrados(){
    _paisesCadastrados = List.from(paises);
  }

  void addPais(Pais pais){
    _paisesCadastrados.add(pais);
    notifyListeners();
  }

  void removePais(Pais pais){
    _paisesCadastrados.remove(pais);
    notifyListeners();
  }

  bool temNaLista(Pais pais){
    return _paisesCadastrados.contains(pais);
  }
}