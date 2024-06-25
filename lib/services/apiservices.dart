import 'dart:convert';
import 'dart:developer'; // Imported the log function
import 'package:http/http.dart' as http;
import 'package:netflixx/common/utils.dart';
import 'package:netflixx/modals/movie_detailed_modal.dart';
import 'package:netflixx/modals/movie_recomondation.dart';
import 'package:netflixx/modals/nowplaying.dart';
import 'package:netflixx/modals/searchmodal.dart';
import 'package:netflixx/modals/topRated.dart';
import 'package:netflixx/modals/tv_series_modal.dart';
import 'package:netflixx/modals/upcomming_modal.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
final String key = "?api_key=$apikey";
late String endPoint;

class ApiServices {
  Future<List<UpcommingModal>> getUpcomingMovies() async {
    log('start');
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";
    try {
      final response = await http.get(Uri.parse(url));

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        final movies = jsonDecode(response.body)['results'] as List;
        log('Success');
        return movies.map((e) => UpcommingModal.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<NowPlaying> getNowPlayingMovies() async {
    log('start');
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";
    try {
      final response = await http.get(Uri.parse(url));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log('Success');
        return NowPlaying.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<TvSeriesModal> getTopRatedSeries() async {
    log('start');
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";
    try {
      final response = await http.get(Uri.parse(url));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log('Success');
        return TvSeriesModal.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load top rated movie series');
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<SearchModal> getSearchMovie(String searchText) async {
    log('helo');
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";
    print('Search url is$url');
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc"
      });

      if (response.statusCode == 200) {
        log('oiii');
        return SearchModal.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Searched  movie ');
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //
    Future<MovieRecomondationModal> getpopularmovies() async {
    log('start');
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";
    try {
      final response = await http.get(Uri.parse(url));
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log('Success');
        return MovieRecomondationModal.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load popular movies');
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }


    Future<MovieDetailModal> getMovieDetail(int movieId) async {
    log('start');
    endPoint = "movie/$movieId";
    final url = "$baseUrl$endPoint$key";
    print('movie  detailurl is$url');
    try {
      final response = await http.get(Uri.parse(url),);

      if (response.statusCode == 200) {
        log('Success');
        return MovieDetailModal .fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load movie detail ');
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }


  
    Future<MovieRecomondationModal> getMovieRecomondation(int movieId) async {
    log('start');
    endPoint = "movie/$movieId/recommendations";
    final url = "$baseUrl$endPoint$key";
    print('recommendations url is$url');
    try {
      final response = await http.get(Uri.parse(url),);

      if (response.statusCode == 200) {
        log('Success');
        return MovieRecomondationModal .fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load more like this ');
      }
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
    Future<TrendingMovieModel> getTrending(String time) async {
    endPoint = "trending/movie/$time";
    final url = "$baseUrl$endPoint$apikey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("success8");
      return TrendingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load popular movies search");
  }
}
