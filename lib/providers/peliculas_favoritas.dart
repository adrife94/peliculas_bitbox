import 'package:flutter/material.dart';

import 'package:peliculas_bitbox/models/pelicula_modelo.dart';
import 'package:peliculas_bitbox/providers/db_provider.dart';

class PeliculasFavoritas with ChangeNotifier {

  List<Pelicula> _listaPeliculas = [];


  PeliculasFavoritas(this._listaPeliculas);

  List<Pelicula> get listaPeliculas => _listaPeliculas;

  set listaPeliculas(List<Pelicula> value) {
  //  DBProvider.db.getPeliculas().then((value) => _listaPeliculas.add(value);
    notifyListeners();

  }

}