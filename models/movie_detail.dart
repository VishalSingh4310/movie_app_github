class MovieDetailed {
  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  VideoResponse? videos;

  MovieDetailed({
    required this.adult,
    required this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.videos,
  });

  factory MovieDetailed.fromJson(Map<String, dynamic> json) {
    return MovieDetailed(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? "",
      belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List<dynamic> ?? [])
          .map((genre) => Genre.fromJson(genre))
          .toList(),
      homepage: json['homepage'] ?? "",
      id: json['id'] ?? 0,
      imdbId: json['imdb_id'] ?? "",
      originalLanguage: json['original_language'] ?? "",
      originalTitle: json['original_title'] ?? "",
      overview: json['overview'] ?? "",
      popularity: json['popularity'] ?? 0.0,
      posterPath: json['poster_path'] ?? "",
      productionCompanies: (json['production_companies'] as List<dynamic> ?? [])
          .map((company) => ProductionCompany.fromJson(company))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic> ?? [])
          .map((country) => ProductionCountry.fromJson(country))
          .toList(),
      releaseDate: json['release_date'] ?? "",
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      spokenLanguages: (json['spoken_languages'] as List<dynamic> ?? [])
          .map((language) => SpokenLanguage.fromJson(language))
          .toList(),
      status: json['status'] ?? "",
      tagline: json['tagline'] ?? "",
      title: json['title'] ?? "",
      video: json['video'] ?? false,
      voteAverage: json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      videos: VideoResponse.fromJson(json['videos']),
    );
  }
}

class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }
}

class ProductionCompany {
  int id;
  String? logoPath;
  String name;
  String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      logoPath: json['logo_path'],
      name: json['name'] ?? "",
      originCountry: json['origin_country'] ?? "",
    );
  }
}

class ProductionCountry {
  String iso3166_1;
  String name;

  ProductionCountry({required this.iso3166_1, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso3166_1: json['iso_3166_1'] ?? "",
      name: json['name'] ?? "",
    );
  }
}

class SpokenLanguage {
  String englishName;
  String iso639_1;
  String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso639_1,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] ?? "",
      iso639_1: json['iso_639_1'] ?? "",
      name: json['name'] ?? "",
    );
  }
}

class Video {
  final String name;
  final String key;
  final String site;
  final String type;
  final String id;

  Video({
    required this.name,
    required this.key,
    required this.site,
    required this.type,
    required this.id,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      name: json['name'],
      key: json['key'],
      site: json['site'],
      type: json['type'],
      id: json['id'],
    );
  }
}

class VideoResponse {
  final List<Video> results;

  VideoResponse({required this.results});

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> resultsList = json['results'];
    final List<Video> results = resultsList.map((result) {
      return Video.fromJson(result);
    }).toList();

    return VideoResponse(results: results);
  }
}
