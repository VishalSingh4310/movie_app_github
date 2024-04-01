import 'dart:developer';

import 'package:movies_app/models/movie_detail.dart';
import 'package:movies_app/utils/genre.dart';

String getYearFromDate(String dateString) {
  try {
    DateTime date = DateTime.parse(dateString);
    return date.year.toString();
  } catch (e) {
    return '';
  }
}

String getGenreNames(List<int>? genreIds) {
  List<String> genreNames = [];
  if (genreIds != null && genreIds.isNotEmpty) {
    for (int id in genreIds) {
      for (Map<String, dynamic> genre in genresList) {
        if (genre['id'] == id && genreNames.length < 2) {
          genreNames.add(genre['name']);
          break; // Once a match is found, no need to continue searching
        }
      }
    }
    String genreString = genreNames.map((genre) => genre).join("/");
    return genreString;
  } else {
    return "";
  }
}

String convertMinutesToHoursMinutes(int? totalMinutes) {
  if (totalMinutes != null && totalMinutes > 0) {
    int hours = totalMinutes ~/ 60;
    int remainingMinutes = totalMinutes % 60;
    return '${hours}h ${remainingMinutes}m';
  } else {
    return '1h 32m';
  }
}

String findTrailerLink(List<Video>? trailerLinks) {
  try {
    if (trailerLinks != null && trailerLinks.isNotEmpty) {
      return trailerLinks
          .firstWhere((result) => result.type.contains('Trailer'))
          .key;
    } else if (trailerLinks!.isNotEmpty) {
      return trailerLinks[0].key;
    } else {
      return '';
    }
  } catch (e) {
    return '';
  }
}
