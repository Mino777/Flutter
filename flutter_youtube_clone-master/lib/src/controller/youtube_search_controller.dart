import 'package:flutter/cupertino.dart';
import 'package:flutter_youtube_clone/src/model/youtube_video_result.dart';
import 'package:flutter_youtube_clone/src/repository/youtube_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YoutubeSearchController extends GetxController {
  String key = "SearchKey";
  RxList<String> history = RxList<String>.empty(growable: true);
  late SharedPreferences profs;
  Rx<YoutubeVideoResult> youtubeVideoResult = YoutubeVideoResult(items: []).obs;
  late String currentKeyword;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    _event;
    profs = await SharedPreferences.getInstance();
    final initData = profs.getStringList(key) ?? [];
    history(initData.map((_) => _.toString()).toList());
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeVideoResult.value.nextPageToken != "") {
        searchYoutube(currentKeyword);
      }
    });
  }

  void search(String search) {
    history.addIf(!history.contains(search), search);
    profs.setStringList(key, history);
    currentKeyword = search;
    searchYoutube(search);
  }

  void searchYoutube(String searchKey) async {
    YoutubeVideoResult? youtubeVideoResultFromServer = await YoutubeRepository
        .to
        .search(searchKey, youtubeVideoResult.value.nextPageToken ?? "");

    if (youtubeVideoResultFromServer != null &&
        youtubeVideoResultFromServer.items != null &&
        youtubeVideoResultFromServer.items!.length > 0) {
      youtubeVideoResult.update((youtube) {
        youtube!.nextPageToken = youtubeVideoResultFromServer.nextPageToken;
        youtube.items!.addAll(youtubeVideoResultFromServer.items!);
      });
    }
  }
}
