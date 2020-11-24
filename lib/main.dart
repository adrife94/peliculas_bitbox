import 'package:flutter/material.dart';
import 'package:peliculas_bitbox/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:peliculas_bitbox/repository/peliculas_favoritas.dart';
import 'package:peliculas_bitbox/screens/pelicula_detalle.dart';
import 'package:peliculas_bitbox/screens/favorites.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PeliculasFavoritas(),
      child: MaterialApp(
        title: 'Peliculas populares',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          // "/" : (context) => HomePage(),
          "detalle": (context) => PeliculaDetalle(),
          "favorita": (context) => Favourites(),
          //   "vista" : (context) => VistasPage()
        },
      ),
    );
  }
}

