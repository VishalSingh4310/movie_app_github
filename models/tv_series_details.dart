import 'package:movies_app/models/movie_detail.dart';

class TVShowDetail {
  final bool? adult;
  final String? backdropPath;
  final List<dynamic>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<dynamic>? genres;
  final String? homepage;
  final int? id;
  final bool? inProduction;
  final List<dynamic>? languages;
  final dynamic lastAirDate;
  final dynamic lastEpisodeToAir;
  final String? name;
  final dynamic nextEpisodeToAir;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<dynamic>? productionCompanies;
  final List<dynamic>? productionCountries;
  final List<Season>? seasons;
  final List<dynamic>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;
  VideoResponse? videos;

  TVShowDetail({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
    this.videos,
  });

  factory TVShowDetail.fromJson(Map<String, dynamic> json) {
    var networksList = json['networks'] as List<dynamic>?;
    List<Network>? networks = networksList != null
        ? networksList.map((network) => Network.fromJson(network)).toList()
        : null;

    var seasonsList = json['seasons'] as List<dynamic>?;
    List<Season>? seasons = seasonsList != null
        ? seasonsList.map((season) => Season.fromJson(season)).toList()
        : null;

    return TVShowDetail(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      createdBy: json['created_by'],
      episodeRunTime: json['episode_run_time'] != null
          ? List<int>.from(json['episode_run_time'])
          : null,
      firstAirDate: json['first_air_date'],
      genres: json['genres'],
      homepage: json['homepage'],
      id: json['id'],
      inProduction: json['in_production'],
      languages: json['languages'],
      lastAirDate: json['last_air_date'],
      lastEpisodeToAir: json['last_episode_to_air'],
      name: json['name'],
      nextEpisodeToAir: json['next_episode_to_air'],
      networks: networks,
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons: json['number_of_seasons'],
      originCountry: json['origin_country'] != null
          ? List<String>.from(json['origin_country'])
          : null,
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: json['popularity']?.toDouble(),
      posterPath: json['poster_path'] ?? '',
      productionCompanies: (json['production_companies'] as List<dynamic> ?? [])
          .map((company) => ProductionCompany.fromJson(company))
          .toList(),
      productionCountries: json['production_countries'],
      seasons: seasons,
      spokenLanguages: json['spoken_languages'],
      status: json['status'],
      tagline: json['tagline'],
      type: json['type'],
      voteAverage: json['vote_average']?.toDouble(),
      voteCount: json['vote_count'],
      videos: VideoResponse.fromJson(json['videos']),
    );
  }
}

class Network {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  Network({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      logoPath: json['logo_path'],
      name: json['name'],
      originCountry: json['origin_country'],
    );
  }
}

class Season {
  final dynamic airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final dynamic posterPath;
  final int? seasonNumber;
  final double? voteAverage;

  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      airDate: json['air_date'],
      episodeCount: json['episode_count'],
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      seasonNumber: json['season_number'],
      voteAverage: json['vote_average']?.toDouble(),
    );
  }
}
