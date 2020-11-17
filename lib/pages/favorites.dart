import 'package:flutter/material.dart';
import 'package:peliculas_bitbox/providers/database.dart';
import 'package:peliculas_bitbox/providers/db_provider.dart';


class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DBProvider.db.getPeliculas(),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;

            return Scaffold(
                appBar: AppBar(
                  title: Text("Peliculas favoritas"),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _mostrarAlertBorrar(context);
                        Navigator.pushNamed(context, 'vista',);
                      },
                    )
                  ],
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
                            color: Colors.red,

                          ),
                          onPressed: () {
                            _mostrarAlert(context, pelicula);
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
            );
             } else {
          return Container(
            child: Text("No tienes ninguna pelicula en la lista de favoritos"),
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
  void _mostrarAlert(BuildContext context, Pelicula pelicula) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
          // title: Text('title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('¿Estas seguro que deseas eliminar \"${pelicula.title}\" de la lista de favoritos?'),
              FadeInImage(
                  placeholder: AssetImage("assets/loading-48.gif"),
                  image: NetworkImage(pelicula.getPosterImg()))
            ],
          ),

          actions: <Widget>[
            FlatButton(
              child: Text('Si'),
              onPressed: () {
                setState(() {
                  DBProvider.db.deletePeliculaId(pelicula.id);
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                }
                );

              },
            ),
            FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(dialogContext).pop() // Dismiss alert dialog
            )
          ],
        );
      },
    );
  }

  void _mostrarAlertBorrar(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
          // title: Text('title'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('¿Estas seguro que deseas eliminar todas las peliculas de tu lista de favoritos?'),
              Icon(Icons.delete, size: 100,)
            ],
          ),

          actions: <Widget>[
            FlatButton(
              child: Text('Si'),
              onPressed: () {
                setState(() {
                  DBProvider.db.deleteAll();
                  Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                });


              },
            ),
            FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(dialogContext).pop() // Dismiss alert dialog
            )
          ],
        );
      },
    );
  }
  }





