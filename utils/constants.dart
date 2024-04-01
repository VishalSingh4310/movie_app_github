import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

var brightness =
    SchedulerBinding.instance.platformDispatcher.platformBrightness;

enum Platforms { movie, tvShow }

const double kDefaultPadding = 20.0;
const String headingMovies = 'Movies';
const String headingUpcomingMovies = 'Upcoming Movies';
const String headingTopRatedMovies = 'Top Rated Movies';
const String headingPopularMovies = 'Popular Movies';

const String headingPopularSeries = 'Popular TV Shows';
const String headingTopRatedSeries = 'Top Rated TV Shows';

const String kImagePrefix500 = "https://image.tmdb.org/t/p/w500";
const String kImagePrefixOriginal = "https://image.tmdb.org/t/p/original";

const String kTopRatedMoviesUrl =
    "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1";
const String kUpcomingMoviesUrl =
    "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1";
const String kPopularMoviesUrl =
    "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1";

const String kPopularTvUrl =
    "https://api.themoviedb.org/3/tv/popular?language=en-US&page=1";

const String kTopRatedSeriesUrl =
    "https://api.themoviedb.org/3/tv/top_rated?language=en-US&page=1";

String kSeriesDetailsUrl(seriesId) {
  return "https://api.themoviedb.org/3/tv/$seriesId?language=en-US&append_to_response=videos";
}

String kSeriesCreditsUrl(seriesId) {
  return "https://api.themoviedb.org/3/tv/$seriesId/aggregate_credits?language=en-US";
}

String kSeriesRecommendationsUrl(seriesId) {
  return "https://api.themoviedb.org/3/tv/$seriesId/recommendations?language=en-US&page=1";
}

String kMoviesDetailsUrl(movieId) {
  return "https://api.themoviedb.org/3/movie/$movieId?language=en-US&append_to_response=videos";
}

String kMoviesCreditsUrl(movieId) {
  return 'https://api.themoviedb.org/3/movie/$movieId/credits?language=en-US';
}

String kSimilarMoviessUrl(movieId) {
  return 'https://api.themoviedb.org/3/movie/$movieId/recommendations?language=en-US&page=1';
}

String kSeachrMoviesUrl(movie) {
  return 'https://api.themoviedb.org/3/search/movie?query=$movie&include_adult=false&language=en-US&page=1';
}

String kYoutubeUrl(videoId) {
  return 'https://www.youtube.com/watch?v=$videoId';
}

const String token =
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjZiMThhMDQzYTM4ODQ0Y2EwYzNiNDc2MzhkZmIwYyIsInN1YiI6IjYzZTI3ZWEyNTI4YjJlMDA4NWM1YWIwYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.g49OtzBFRAPPoHSiGr_2ZPdpFKqQYo9qDDj9HnVotF4";

const kLinearGradientBlack = LinearGradient(
  colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);
const kLinearGradientWhite = LinearGradient(
  colors: [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(0, 255, 255, 255),
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);
