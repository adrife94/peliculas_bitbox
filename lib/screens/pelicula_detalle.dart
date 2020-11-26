import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peliculas_bitbox/models/movie_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate([
            //  SizedBox(height: 1.0),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Column(
                    children: [
                      Text("Estreno: ${pelicula.releaseDate}"),
                      _crearRatingBar(pelicula),
                //      Text(pelicula.voteAverage.toString()),
                      SizedBox(height: 15.0),
                      Text(
                        pelicula.overview,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )
              ),
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: Hero(
          tag: pelicula.id,
          child: FadeInImage(
            image: NetworkImage(pelicula.getBackgroundImg()),
            placeholder: AssetImage("assets/loading-48.gif"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _crearRatingBar (Pelicula pelicula) {
    return RatingBar.builder(
      initialRating: pelicula.voteAverage/2,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
        size: 1,
      ),
    );
  }

}
