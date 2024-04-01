class TVShow {
  final int page;
  final List<TVShowResult> results;
  final int totalPages;
  final int totalResults;

  TVShow({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    var resultsList = json['results'] as List<dynamic>;
    List<TVShowResult> results =
        resultsList.map((result) => TVShowResult.fromJson(result)).toList();

    return TVShow(
      page: json['page'],
      results: results,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

class TVShowResult {
  final String backdropPath;
  final String firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  TVShowResult({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TVShowResult.fromJson(Map<String, dynamic> json) {
    return TVShowResult(
      backdropPath: json['backdrop_path'] ?? "",
      firstAirDate: json['first_air_date'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      name: json['name'],
      originCountry: List<String>.from(json['origin_country']),
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'] ?? '',
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }
}
