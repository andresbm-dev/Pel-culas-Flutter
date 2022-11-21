import 'dart:convert';

import 'package:peliculas/models/models.dart';

class PopularMoviesResponse {
  PopularMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movies> results;
  int totalPages;
  int totalResults;

  factory PopularMoviesResponse.fromJson(String str) => PopularMoviesResponse.fromMap(json.decode(str));

  factory PopularMoviesResponse.fromMap(Map<String, dynamic> json) => PopularMoviesResponse(
    page: json["page"],
    results: List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}

