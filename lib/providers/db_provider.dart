import 'package:sqflite/sqflite.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();  //Esto es un constructor privado

Future<Database> get database async {
  if(_database != null) return _database;
  
  _database = await initDB();
  
  return _database;
}

  initDB() {}


}