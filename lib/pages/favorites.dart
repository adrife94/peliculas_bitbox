import 'package:flutter/material.dart';

import 'package:peliculas_bitbox/providers/db_provider.dart';
import 'package:peliculas_bitbox/providers/peliculas_favoritas.dart';
import 'package:provider/provider.dart';


class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {


  @override
  Widget build(BuildContext context) {



   /* final  listaFavoritos = Provider.of<PeliculasFavoritas>(context);
    listaFavoritos.listaPeliculas;*/

            return Scaffold(
                appBar: AppBar(
                  title: Text("Peliculas favoritas"),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _mostrarAlertBorrar(context);
                      //  Navigator.pushNamed(context, 'favorita',);
                      },
                    )
                  ],
                ),
                body: Container(
                  child: _creadorFavoritos(),
                ),
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
                  PeliculasFavoritas();
                  Navigator.of(dialogContext).pop();
              /*    if (peliculas != null) {


                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Actualmente no dispone de ninguna pelicula en favoritos"),
                    ));
                  }*/
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


  Widget _creadorFavoritos() {

    return FutureBuilder(

      future: DBProvider.db.getPeliculas(),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
      if (snapshot.hasData) {
      final peliculas = snapshot.data;
          return ListView(
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

          );
        } else {
          return Container(
              height: 400.0,
              child: Center(
                  child: CircularProgressIndicator()
              )
          );

        }
      },
    );
  }
  }





