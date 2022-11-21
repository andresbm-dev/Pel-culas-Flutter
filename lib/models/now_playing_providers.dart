import 'dart:convert';

import 'models.dart';

class NowPlayingRespnse {
  NowPlayingRespnse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates dates;
  int page;
  List<Movies> results;
  int totalPages;
  int totalResults;

  factory NowPlayingRespnse.fromJson(String str) => NowPlayingRespnse.fromMap(json.decode(str));


  factory NowPlayingRespnse.fromMap(Map<String, dynamic> json) => NowPlayingRespnse(
    dates: Dates.fromMap(json["dates"]),
    page: json["page"],
    results: List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

}


