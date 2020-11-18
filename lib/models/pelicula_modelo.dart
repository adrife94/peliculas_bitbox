class Peliculas {

  List<Pelicula> items = List();

  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final pelicula = Pelicula.fromJsonMap(item);
      items.add( pelicula );
    }

  }

}



class Pelicula {
  String uniqueId;
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap( Map<String, dynamic> json ) {

    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];


  }

  Pelicula.fromJsonMap2( Map<String, dynamic> json ) {

    voteCount        = json['voteCount'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['voteAverage'] / 1;
    title            = json['title'];
    posterPath       = json['posterPath'];
    backdropPath     = json['backdroPath'];
     overview         = json['overview'];
    releaseDate      = json['releaseDate'];


  }

  Pelicula.fromJsonMapID2( Map<String, dynamic> json ) {

    voteCount        = json['vote_count'];
    id               = json['id'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    posterPath       = json['poster_path'];
    originalTitle    = json['original_title'];
    backdropPath     = json['backdrop_path'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];


  }

  Pelicula.fromJsonMapId( Map<String, dynamic> json ) {

    id               = json['id'];



  }

  getPosterImg() {
    if(posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    } else {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/1200px-Imagen_no_disponible.svg.png';
    }

  }

  getBackgroundImg() {
    if(posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    } else {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/1200px-Imagen_no_disponible.svg.png';
    }

  }

}