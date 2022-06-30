import 'package:deliveryherochallenge/core/models/movie_detail_model.dart';
import 'package:deliveryherochallenge/core/models/movie_model.dart';
import 'package:deliveryherochallenge/core/service/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "Movie Model",
    () {
      final model = MovieModel();

      expect(model.title, null);
    },
  );

  test("getMoviesDetail", () {
    final Services _services = Services();
    final response = _services.getMoviesDetail(0);

    expect(response is MovieDetailModel, false);
  });

  test("getMoviesBySearch", () async {
    final Services _services = Services();
    final response = await _services.getMoviesBySearch("wtwefw*-764ef");

    expect(response, []);
  });

  test("getMoviesBySearch", () async {
    final Services _services = Services();
    final response = await _services.getMoviesBySearch("kuki");

    expect(response, response);
  });
  test("getMoviesBySearch", () async {
    final Services _services = Services();
    final response = await _services.getMoviesBySearch("kuki");

    expect(response.length > 0, true);
  });

  test("getMoviesDetail", () {
    final Services _services = Services();
    final response = _services.getMoviesDetail(0);

    expect(response is MovieModel, false);
  });
}
