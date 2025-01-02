import 'package:get/get.dart';
import 'package:tubes2_uas_kelompok2/core/utils/print_log.dart';
import 'package:tubes2_uas_kelompok2/data/vote/datasource/vote_datasource.dart';
import 'package:tubes2_uas_kelompok2/data/vote/responsesmodel/vote_responses_model_get.dart';

class VoteController extends GetxController {
  final VoteDatasource _datasource = VoteDatasource();
  RxList<VoteResponsesModelGet> vote = <VoteResponsesModelGet>[].obs;
  RxList<VoteResponsesModelGet> searchResult = <VoteResponsesModelGet>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVote();
  }

  Future<void> fetchVote() async {
    isLoading.value = true;
    try {
      final result = await _datasource.getVote();
      if (result != null) {
        vote.value = result;
        searchResult.value =
            result; // Sinkronkan searchResult dengan data awal.
      }
    } catch (e) {
      printLog.printLog("Error fetching votes: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void searchVote(String query) {
    if (query.isEmpty) {
      searchResult.value = vote;
    } else {
      searchResult.value = vote
          .where((element) => element.id.toString().contains(query))
          .toList();
    }
  }

  Future<void> deleteVote(int id) async {
    try {
      final result = await _datasource.deleteVote(id);
      if (result != null) {
        vote.removeWhere((element) => element.id == id);
        searchResult.removeWhere((element) => element.id == id);
      }
    } catch (e) {
      printLog.printLog("Error deleting vote: $e");
    }
  }
}
