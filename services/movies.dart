import "dart:convert";
import "dart:developer";
import "package:http/http.dart" as http;
import "package:movies_app/models/movie.dart";
import "package:movies_app/models/movie_credits.dart";
import "package:movies_app/models/movie_detail.dart";
import "package:movies_app/utils/constants.dart";

class RemoteService {
  Future<MovieList?> getTopMovies() async {
    var client = http.Client();
    var uri = Uri.parse(kTopRatedMoviesUrl);
    var response = await client.get(uri,
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final moviesList = MovieList.fromJson(data);
      return moviesList;
    }
    return null;
  }

  Future<MovieList?> getUpcomingMovies() async {
    var client = http.Client();
    var uri = Uri.parse(kUpcomingMoviesUrl);
    var response = await client.get(uri,
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final moviesList = MovieList.fromJson(data);
      return moviesList;
    }
    return null;
  }

  Future<MovieList?> getPopularMovies() async {
    var client = http.Client();
    var uri = Uri.parse(kPopularMoviesUrl);
    var response = await client.get(uri,
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final moviesList = MovieList.fromJson(data);
      return moviesList;
    }
    return null;
  }

  Future<MovieDetailed?> getMovieDetails(movieId) async {
    var client = http.Client();
    var uri = Uri.parse(kMoviesDetailsUrl(movieId));
    var response = await client.get(uri,
        headers: {'Accept': 'application/json', 'Authorization': token});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final movieDetails = MovieDetailed.fromJson(data);
      return movieDetails;
    }
    return null;
  }

  Future<MovieInfo?> getMovieCreditsDetails(movieId) async {
    try {
      var client = http.Client();
      var uri = Uri.parse(kMoviesCreditsUrl(movieId));
      var response = await client.get(uri,
          headers: {'Accept': 'application/json', 'Authorization': token});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movieCreditsDetails = MovieInfo.fromJson(data);
        return movieCreditsDetails;
      }
      return null;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<MovieList?> getSimilarMovies(movieId) async {
    try {
      var client = http.Client();
      var uri = Uri.parse(kSimilarMoviessUrl(movieId));
      var response = await client.get(uri,
          headers: {'Accept': 'application/json', 'Authorization': token});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movieDetails = MovieList.fromJson(data);
        return movieDetails;
      }
      return null;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<MovieList?> searchMovies(movie) async {
    try {
      log("mopvie name $movie");
      var client = http.Client();
      var uri = Uri.parse(kSeachrMoviesUrl(movie));
      var response = await client.get(uri,
          headers: {'Accept': 'application/json', 'Authorization': token});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movieDetails = MovieList.fromJson(data);
        return movieDetails;
      }
      return null;
    } catch (e) {
      log('request error $e');
      return null;
    }
  }
}
