// To parse this JSON data, do
//
//     final favoritesResponseDelete = favoritesResponseDeleteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavoritesResponseDelete favoritesResponseDeleteFromJson(String str) =>
    FavoritesResponseDelete.fromJson(json.decode(str));

String favoritesResponseDeleteToJson(FavoritesResponseDelete data) =>
    json.encode(data.toJson());

class FavoritesResponseDelete {
  final String message;

  FavoritesResponseDelete({
    required this.message,
  });

  factory FavoritesResponseDelete.fromJson(Map<String, dynamic> json) =>
      FavoritesResponseDelete(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
