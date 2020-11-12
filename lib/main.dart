import 'package:flutter/material.dart';
import 'package:peliculas_bitbox/pages/pelicula_detalle.dart';
import 'package:peliculas_bitbox/providers/peliculas_providers.dart';


import 'models/pelicula_modelo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // title: 'Peliculas populares',
      debugShowCheckedModeBanner: false,
     home: HomePage(),
      routes: <String, WidgetBuilder> {
       // "/" : (context) => HomePage(),
        "detalle" : (context) => PeliculaDetalle()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
           //     delegate: DataSearch(),
                // query: 'Hola'
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              showSearch(
                context: context,
                //     delegate: DataSearch(),
                // query: 'Hola'
              );
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          child: _lista(context),

        ),
      ),
    );
  }

  Widget _lista(BuildContext context) {
    final peliculasProvider = PeliculasProvider();
    return FutureBuilder(
        future: peliculasProvider.getPopulares(),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if( snapshot.hasData ) {

            final peliculas = snapshot.data;

            return ListView(
                children: peliculas.map( (pelicula) {
                  print(pelicula.title);
                  return ListTile(
                    leading: FadeInImage(
                      image: NetworkImage( pelicula.getPosterImg() ),
                      placeholder: AssetImage('assets/loading-48.gif'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text( pelicula.title ),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        _mostrarAlert(context, pelicula);
                      },
                    ),
                    onTap: (){
                   //   pelicula.uniqueId = '';
                      Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                    },
                  );
                }).toList()
            );

          } else {
            return Center(
                child: CircularProgressIndicator()
            );
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
              Text('¿Estas seguro que deseas añadir \"${pelicula.title}\" a la lista de favoritos?'),
              FadeInImage(
                  placeholder: AssetImage("assets/loading-48.gif"),
                  image: NetworkImage(pelicula.getPosterImg()))




            ],
          ),

          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            FlatButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(dialogContext).pop() // Dismiss alert dialog
            )
          ],
        );
      },
    );
  }


}
