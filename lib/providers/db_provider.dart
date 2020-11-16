import 'dart:io';

import 'package:path/path.dart';
import 'package:peliculas_bitbox/models/pelicula_modelo.dart';
export 'package:peliculas_bitbox/models/pelicula_modelo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();  //Esto es un constructor privado

Future<Database> get database async {
  if(_database != null) return _database;
  
  _database = await initDB();
  
  return _database;
}

  initDB() async {

  Directory documentsDirectory = await getApplicationDocumentsDirectory();

  final path = join(documentsDirectory.path, 'PeliculasDB.db');

  return await openDatabase(
    path,
    version: 1,
    onOpen: (db) {

    },
    onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Pelicula (id INTEGER PRIMARY KEY, voteCount INTEGER, voteAverage REAL, title TEXT, overview TEXT, backdropPath TEXT, releaseDate TEXT, posterPath TEXT);'
      );
    }
  );

  }

  // Crear registros

nuevoPeliculaRaw(Pelicula pelicula) async {
  final db = await database;

  final res = await db.rawInsert("INSERT INTO Pelicula (id, voteCount, voteAverage, title, overview, backdropPath, releaseDate, posterPath) VALUES (${pelicula.id}, ${pelicula.voteCount}, ${pelicula.voteAverage}, '${pelicula.title}', '${pelicula.overview}', '${pelicula.backdropPath}', '${pelicula.releaseDate}', '${pelicula.posterPath}' );");

  print("insertado!!!!!!!!!!!!!!!!!!!!!!!!! ${pelicula.id}");
  return res;
}

// Obtener informacion

Future<bool> getPeliculaId(int id) async {

  final db = await database;

  final respuesta = await db.query('Pelicula', where: 'id= ?', whereArgs: [id]);

  return respuesta.isNotEmpty ? true : false;
  
}

  Future<List<Pelicula>> getPeliculas() async {

    final db = await database;

    final respuesta = await db.query('Pelicula');


    List<Pelicula> list = respuesta.isNotEmpty ? respuesta.map( (peli) => Pelicula.fromJsonMapId(peli)).toList() : [];


    return list;

  }

// Eliminar registro

Future<int> deleteScan(int id) async {
  final db = await database;
  final res = await db.delete('Pelicula', where: 'id = ?', whereArgs: [id]);
  return res;
}

// Eliminar todos los registros
  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Pelicula');
    return res;
  }

}