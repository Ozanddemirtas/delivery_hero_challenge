import 'package:deliveryherochallenge/_.dart';
import 'package:deliveryherochallenge/core/models/movie_detail_model.dart';
import 'package:deliveryherochallenge/core/models/movie_model.dart';
import 'package:deliveryherochallenge/core/service/services.dart';

class AppController extends GetxController {
  RxList<MovieModel> movies = <MovieModel>[].obs;
  Rx<MovieDetailModel> movie = MovieDetailModel().obs;

  RxBool moviesLoading = false.obs;
  RxBool movieLoading = false.obs;

  final Services _services = Services();

  Future search(String q) async {
    moviesLoading.value = true;
    movies.value = await _services.getMoviesBySearch(q);
    moviesLoading.value = false;
  }

  Future detail(int id) async {
    movieLoading.value = true;
    movie.value = (await _services.getMoviesDetail(id))!;
    movieLoading.value = false;
  }
}
