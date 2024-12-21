import 'dart:math';
import 'package:dio/dio.dart';
import 'package:tubes2_uas_kelompok2/core/api_services/dio_module.dart';
import 'package:tubes2_uas_kelompok2/core/api_services/endpoint.dart';
import 'package:tubes2_uas_kelompok2/core/utils/print_log.dart';
import 'package:tubes2_uas_kelompok2/data/favorite/responsesmodel/favorite_responses_model_delete.dart';
import 'package:tubes2_uas_kelompok2/data/favorite/responsesmodel/favorite_responses_model_get.dart';
import 'package:tubes2_uas_kelompok2/data/favorite/responsesmodel/favorite_responses_model_post.dart';
import 'package:tubes2_uas_kelompok2/data/favorite/responsesmodel/favorite_responses_model_search.dart';

class FavoriteDatasource {
  final HttpManager _httpManager = HttpManager();

  Future<List<FavoritesResponsesModelGet>> getFavorite() async {
    try {
      final response = await _httpManager.restRequest(
        url: ApiConstants.favoriteGetEndpoint,
        method: HttpMethods.get,
        useAuth: true,
      );

      PrintLog.printLog("getFavorite Datasource response: ${response}");

      if (response['statusCode'] == 200 && response.containsKey('data')) {
        final List<dynamic> data = response['data'];

        return data
            .map((item) => FavoritesResponsesModelGet.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load Favorite data');
      }
    } catch (e) {
      throw Exception('failed to load get Favorite');
    }
  }

  Future<FavoritesResponsesModelPost?> createFavorite(
      FavoritesResponsesModelPost data) async {
    try {
      final response = await _httpManager.restRequest(
        url: ApiConstants.favoriteGetEndpoint,
        method: HttpMethods.post,
        body: data.toJson(),
      );

      if (response['statusCode'] == 200) {
        PrintLog.printLog("getFavorite Datasource response: ${response}");
        return FavoritesResponsesModelPost.fromJson(response['data']);
      } else {
        PrintLog.printLog(
            "creatFavorite Datasource response: ${response['statusmessage']}");
        return null;
      }
    } catch (e) {
      throw Exception('failed to load  create Favorite');
    }
  }

  Future<FavoritesResponseModelDelete?> deleteFavorite(int favoriteId) async {
    try {
      final response = await _httpManager.restRequest(
        url: ApiConstants.favByIdGetEndpoint(favoriteId),
        method: HttpMethods.post,
        useAuth: true,
      );

      final message = response['message'];
      final statusMessage = response['statusMessage'];

      if (message == 'SUCCES' || statusMessage == 'OK') {
        if (response['data'] != null &&
            response['data'] is Map<String, dynamic>) {
          return FavoritesResponseModelDelete.fromJson(response['data']);
        } else {
          return FavoritesResponseModelDelete(
            message: message ?? "SUCCES",
          );
        }
      } else {
        PrintLog.printLog(
            'deleteFavorite Datasource response: ${statusMessage ?? "Unknown Error"}');
        return null;
      }
    } catch (e) {
      PrintLog.printLog("delete Favorite Datasource response: $e");
    }
  }

  Future<FavoritesResponsesModelSearch?> searchFavorite(int favoriteId) async {
    try {
      final response = await _httpManager.restRequest(
        url: ApiConstants.favByIdGetEndpoint(favoriteId),
        method: HttpMethods.get,
        useAuth: true,
      );

      if (response['statusCode'] == 200) {
        PrintLog.printLog(
            'searchFavorite Datasource response: ${response['data']}');
        return FavoritesResponsesModelSearch.fromJson(response['data']);
      } else {
        PrintLog.printLog(
            'searchFavorite DataSource failed: ${response['statusMessage']}');
        return null;
      }
    } catch (e) {
      throw Exception('failed to load search Favorite');
    }
  }
}
