class MovieInfo {
  final int id;
  final List<Cast> cast;

  MovieInfo({
    required this.id,
    required this.cast,
  });

  factory MovieInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> castList = json['cast'];

    return MovieInfo(
      id: json['id'],
      cast: castList.map((e) => Cast.fromJson(e)).toList(),
    );
  }
}

class Cast {
  final int id;
  final String? knownForDepartment;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final String? character;
  final int order;

  Cast({
    required this.id,
    this.knownForDepartment,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.character,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      originalName: json['original_name'],
      popularity: json['popularity'],
      profilePath: json['profile_path'],
      character: json['character'],
      order: json['order'],
    );
  }
}
