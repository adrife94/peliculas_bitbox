import 'package:flutter/material.dart';

import 'package:peliculas_bitbox/models/pelicula_modelo.dart';
import 'package:peliculas_bitbox/providers/db_provider.dart';

class PeliculasFavoritas with ChangeNotifier {

   final List<Pelicula> _listaPeliculas = [];


  PeliculasFavoritas() {     // El factory revisa si ya existe una instancia, si existe devuelve la instancia, sino la crea
    cargardatos();
  }

  List<Pelicula> get listaPeliculas => _listaPeliculas;

  set listaPeliculas(List<Pelicula> value) {
    _listaPeliculas.clear();
    _listaPeliculas.addAll(value);
  //  DBProvider.db.getPeliculas().then((value) => _listaPeliculas.add(value);
    notifyListeners();

  }

  void updateProvider() {
    cargardatos();
    notifyListeners();
  }

  Future<List<Pelicula>> cargardatos() async {
  listaPeliculas = await DBProvider.db.getPeliculas();
}

}