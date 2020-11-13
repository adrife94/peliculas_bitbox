import 'dart:io';

import 'package:path/path.dart';
import 'package:peliculas_bitbox/models/pelicula_modelo.dart';
export 'package:peliculas_bitbox/models/pelicula_modelo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Database1 {

  Database _db;

  Database1._(); //Esto es un constructor privado


  initDB() async {
    _db = await openDatabase(
        'my:db.db', version: 1, onCreate: (Database db, int version) {
      db.execute('CREATE TABLE Pelicula (id TEXT PRIMARY KEY);');
    }
    );
  }


  // Crear registros

  nuevoPeliculaRaw(Pelicula pelicula) async {
    _db.rawInsert(
        "INSERT INTO Pelicula(id) "
            "VALUES ('${pelicula.id}');"
    );

    print("insertado!!!!!!!!!!!!!!!!!!!!!!!!!");

  }
}


