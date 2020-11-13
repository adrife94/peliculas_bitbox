import 'package:flutter/material.dart';
import 'package:peliculas_bitbox/providers/database.dart';
import 'package:peliculas_bitbox/providers/db_provider.dart';

class Favourites extends StatelessWidget {


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
         /* final peliculas = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: Text("Peliculas favoritas"),
            ),
            body: ListView(
              children: peliculas.map( (pelicula) {

                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage( pelicula.getPosterImg() ),
                    placeholder: AssetImage('assets/loading-48.gif'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text( pelicula.title ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: DBProvider.db.getPeliculaId(pelicula.id) == null ? Colors.red : null,
                    ),
                    onPressed: () {
                     // _mostrarAlert(context, pelicula);
                    },
                  ),
                  onTap: (){
                    //   pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }
            ).toList()


          )
          );*/
        } else {
          return Container(
            child: Text("No"),
          );
         /* return Scaffold(
            appBar: AppBar(
              title: Text("Peliculas no favoritas"),
            ),
            body: Text("Actualmente no tiene peliculas favoritas"),
          );*/
        }

      }
    );
  }
}
