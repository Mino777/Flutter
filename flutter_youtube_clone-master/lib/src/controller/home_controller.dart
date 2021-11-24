import 'package:flutter/cupertino.dart';
import 'package:flutter_youtube_clone/src/model/youtube_video_result.dart';
import 'package:flutter_youtube_clone/src/repository/youtube_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(items: []).obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _videoLoad();
    _event();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent && youtubeResult.value.nextPageToken != "") {
        _videoLoad();
      }
    });
  }

  void _videoLoad() async {
    YoutubeVideoResult? youtubeVideoResult = await YoutubeRepository.to
        .loadVideos(youtubeResult.value.nextPageToken ?? "");

    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items!.length > 0) {
      youtubeResult.update((item) {
        item?.nextPageToken = youtubeVideoResult.nextPageToken;
        item!.items!.addAll(youtubeVideoResult.items!);
      });
    }
  }
}
