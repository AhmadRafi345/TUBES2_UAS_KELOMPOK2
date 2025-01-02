import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tubes2_uas_kel9/core/global_component/searchview.dart';
import 'package:tubes2_uas_kel9/data/vote/responsesmodel/vote_responses_model_get.dart';
import 'package:tubes2_uas_kel9/features/vote/controller/vote_controller.dart';
import 'package:tubes2_uas_kel9/features/vote/widgets/vote_cardview.dart';
import 'package:tubes2_uas_kel9/features/home/widgets/home_cardview.dart';

class VoteScreen extends StatelessWidget {
  const VoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pastikan Anda memiliki controller yang didefinisikan
    final VoteController controller = Get.put(VoteController());

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(),
              SearchViewWidget(
                hintText: 'Cari Daftar Kucing Vote',
                onSearch: controller.searchVote,
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return _BuildLoadingIndicator();
                  } else if (controller.searchResult.isEmpty) {
                    return _BuildEmptyVote(controller);
                  } else {
                    return _BuildVoteList(controller);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          await controller.fetchVote();
        },
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    );
  }

  // Contoh implementasi metode _buildHeaderSection
  Widget _buildHeaderSection() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kucing Vote',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Daftar Kucing Yang Telah anda vote',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _BuildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _BuildEmptyVote(VoteController controller) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Belum ada kucing vote',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            await controller.fetchVote();
          },
          child: const Text('Refresh'),
        ),
      ],
    ));
  }

  Widget _BuildVoteList(VoteController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: controller.searchResult.length,
        itemBuilder: (context, index) {
          final vote = controller.searchResult[index];
          return VoteCardview(
            vote: vote,
            onDeleted: () => controller.deleteVote(vote.id),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
