// To parse this JSON data, do
//
//     final popularAnime = popularAnimeFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models.dart';

class PopularAnime {
    PopularAnime({
       required this.top,
    });


    List<Anime> top;

    factory PopularAnime.fromJson(String str) => PopularAnime.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PopularAnime.fromMap(Map<String, dynamic> json) => PopularAnime(
        top: List<Anime>.from(json["top"].map((x) => Anime.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "top": List<dynamic>.from(top.map((x) => x.toMap())),
    };
}


