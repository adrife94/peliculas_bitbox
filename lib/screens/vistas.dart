import 'package:flutter/material.dart';
import 'package:peliculas_bitbox/repository/db_provider.dart';


class VistasPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: DBProvider.db.getPeliculas(),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return Container(
              child: Text(peliculas.length.toString()),
            );
          } else {
            return Container(
              child: Text("No"),
            );
          }
        }
    );
  }
}