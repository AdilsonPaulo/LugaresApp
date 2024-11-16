import 'package:flutter/material.dart';
import 'package:f05_lugares_app/model/lugar.dart';

class LugaresFavoritos with ChangeNotifier{

  List<Lugar> _lugaresFavoritos = [];

  List<Lugar> get favoritos => _lugaresFavoritos;

  void addFavoritos(Lugar lugar){
    _lugaresFavoritos.add(lugar);
    notifyListeners();
  }

  void removerFavoritos(Lugar lugar){
    _lugaresFavoritos.remove(lugar);
    notifyListeners();
  }

  bool temNaLista(Lugar lugar){
    return _lugaresFavoritos.contains(lugar);
  }
}