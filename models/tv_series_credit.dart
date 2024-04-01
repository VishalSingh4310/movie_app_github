class CastList {
  final int? id;
  final List<Cast>? cast;

  CastList({
    this.id,
    this.cast,
  });

  factory CastList.fromJson(Map<String, dynamic> json) {
    var castList = json['cast'] as List<dynamic>?;
    List<Cast>? cast;
    if (castList != null) {
      cast = castList.map((castItem) => Cast.fromJson(castItem)).toList();
    } else {
      cast = null;
    }

    return CastList(
      id: json['id'],
      cast: cast,
    );
  }
}

class Cast {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final List<Role>? roles;
  final int? totalEpisodeCount;
  final int? order;

  Cast({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.roles,
    this.totalEpisodeCount,
    this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    var rolesList = json['roles'] as List<dynamic>?;
    List<Role>? roles = rolesList != null
        ? rolesList.map((role) => Role.fromJson(role)).toList()
        : null;

    return Cast(
      adult: json['adult'],
      gender: json['gender'],
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      originalName: json['original_name'],
      popularity: json['popularity']?.toDouble(),
      profilePath: json['profile_path'],
      roles: roles,
      totalEpisodeCount: json['total_episode_count'],
      order: json['order'],
    );
  }
}

class Role {
  final String? creditId;
  final String? character;
  final int? episodeCount;

  Role({
    this.creditId,
    this.character,
    this.episodeCount,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      creditId: json['credit_id'],
      character: json['character'],
      episodeCount: json['episode_count'],
    );
  }
}
