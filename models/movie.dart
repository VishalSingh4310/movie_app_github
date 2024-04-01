class MovieList {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MovieList({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) {
    List<Movie> movieList = List<Movie>.from(json['results'].map((movie) {
      return Movie.fromJson(movie);
    }));
    return MovieList(
      page: json['page'],
      results: movieList,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

class Movie {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }
}
