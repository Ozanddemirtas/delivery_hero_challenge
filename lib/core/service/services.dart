import 'dart:convert';

import 'package:deliveryherochallenge/core/models/movie_detail_model.dart';
import 'package:deliveryherochallenge/core/models/movie_model.dart';
import 'package:deliveryherochallenge/core/service/service_config.dart';
import 'package:deliveryherochallenge/core/service/service_helper.dart';
import 'package:http/http.dart' as http;

class Services {
  Future<List<MovieModel>> getMoviesBySearch(String query) async {
    List<MovieModel> list = [];
    http.Response response = await http.get(ServiceHelper.getURl("search/movie?api_key=${ServiceConfig.apiKey}&query=$query"));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      for (var item in data["results"]) {
        list.add(MovieModel.fromMap(item));
      }
    }
    return list;
  }

  Future<MovieDetailModel?> getMoviesDetail(int id) async {
    http.Response response = await http.get(ServiceHelper.getURl("movie/$id?api_key=${ServiceConfig.apiKey}"));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      return MovieDetailModel.fromJson(data);
    }
    return null;
  }
}
