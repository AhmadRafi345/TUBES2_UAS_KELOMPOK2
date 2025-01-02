import 'dart:math';
import 'package:dio/dio.dart';
import 'package:tubes2_uas_kelompok2/core/api_services/dio_module.dart';
import 'package:tubes2_uas_kelompok2/core/api_services/endpoint.dart';
import 'package:tubes2_uas_kelompok2/core/utils/print_log.dart';
import 'package:tubes2_uas_kelompok2/data/favorite/responsesmodel/favorite_responses_model_delete.dart';
import 'package:tubes2_uas_kelompok2/data/favorite/responsesmodel/favorite_responses_model_get.dart';
import 'package:tubes2_uas_kelompok2/data/favorite/responsesmodel/favorite_responses_model_post.dart';
import 'package:tubes2_uas_kelompok2/data/favorite/responsesmodel/favorite_responses_model_search.dart';

class VoteDatasource {
  final HttpManager _httpManager = HttpManager();

  Future<List<VoteResponsesModelGet>> getVote() async {
    try {
      final response = await _httpManager.restRequest(
        url: ApiConstants.VoteGetEndpoint,
        method: HttpMethods.get,
        useAuth: true,
      );

      PrintLog.printLog("get Vote Datasource response: ${response}");

      if (response['statusCode'] == 200 && response.containsKey('data')) {
        final List<dynamic> data = response['data'];

        return data.map(
        (item){
          if(item['image'] == null || item['image'].isEmpty){
            item['image'] = {
              'id' : '', 
              'url' : '',
            };
          }
          return VoteResponsesModelGet.formJson(item);
        }
      ).toList(); 
      } else {
        throw Exception('Failed to load vote  invalid format');
      }
    } catch (e) {
      throw Exception('Failed to load vote');
    }
  }

  Future<VoteResponsesModelPost?> createVote(
    VoteRequestsModel data) async {
    try {
      final response = await httpManager.restRequest(
        url: ApiConstants.voteGetEndpoint(voteId),
        method: HttpMethods.delete,
        useAuth: true,
      );
      final statusCode = response['statusCode'];
      final statusMessage = response['statusMessage'];

       if (statusCode == 200 || statusCode == 201) {
        if (response['data'] != null && 
        response['data'] is Map<String, dynamic>){
          printLog("create Vote datasource $response['data]");
        
        return VoteResponsesModelPost.fromJson(response['data']);
        } else {
          printLog("create Vote datasource $response['data]");
          return VoteResponsesModelPost(
            message: statusMessage ?? "SUCCESS",
            id: 0,
            imageId: '',
            subId: '',
            value: 0,
            countryCode: '',
          );
        }
      } else {
        printLog(
          "create favorite response: ${statusMessage ?? "Unkwon errors"}");
      }
        return null;
      }
    }
    

  Future<VoteResponsesModelDelete?> deleteVote(int voteId) async {
    try {
      final response = await httpManager.restRequest(
        url: ApiConstants.voteByIdGetEndpoint(voteId),
        method: HttpMethods.delete,
        useAuth: true,
      );

      final message = response['message'] ?? '';
      final statusMessage = response['statusMessage'];

      if (message == 'SUCCESS' || statusMessage == 'OK') {
        if (response['data'] != null &&
            response['data'] is Map<String, dynamic>) {
          return VoteResponsesModelDelete.fromJson(response['data']);
        } else {
          return VoteResponsesModelDelete(
            message: message ?? "SUCCESS",
          );
        }
      } else {
        printLog(
            "delete Vote Datasource response: ${statusMessage ?? "Unknown Error"}");
      }
      return null;
    } catch (e) {
      printLog("delete Vote Datasource response: $e");
      return null;
    }
  }


  Future<VoteResponsesModelSearch?> searchVote(int voteId) async {
    try {
      final response = await httpManager.restRequest(
        url: ApiConstants.voteByIdGetEndpoint(voteId),
        method: HttpMethods.get,
        useAuth: true,
      );

      if (response['statusCode'] == 200) {
        return VoteResponsesModelSearch.fromJson(response['data']);
      } else {
        printLog("search Vote Datasource response: ${response['statusMessage']}");
        return null;
      }
    } catch (e) {
      printLog("search Vote Datasource response: $e");
      return null;
    }
  }
}