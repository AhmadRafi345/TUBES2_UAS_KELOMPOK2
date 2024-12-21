// To parse this JSON data, do
//
//     final favoritesResponseModelDelete = favoritesResponseModelDeleteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavoritesResponseModelDelete favoritesResponseModelDeleteFromJson(String str) =>
    FavoritesResponseModelDelete.fromJson(json.decode(str));

String favoritesResponseModelDeleteToJson(FavoritesResponseModelDelete data) =>
    json.encode(data.toJson());

class FavoritesResponseModelDelete {
  final String message;

  FavoritesResponseModelDelete({
    required this.message,
  });

  factory FavoritesResponseModelDelete.fromJson(Map<String, dynamic> json) =>
      FavoritesResponseModelDelete(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
