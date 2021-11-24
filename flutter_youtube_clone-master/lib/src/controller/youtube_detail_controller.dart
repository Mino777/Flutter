import 'package:flutter_youtube_clone/src/controller/video_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDetailController extends GetxController {
  late VideoController videoController;
  late YoutubePlayerController playerController;
  @override
  void onInit() {
    super.onInit();
    videoController = Get.find(tag: Get.parameters["videoId"]);
    playerController = YoutubePlayerController(
      initialVideoId: Get.parameters["videoId"]!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  String get title => videoController.video.snippet.title;
  String get viewCount => "조회수 ${videoController.statistics.value.viewCount}회";
  String get likeCount => "${videoController.statistics.value.likeCount}";
  String get disLikeCount => "${videoController.statistics.value.dislikeCount}";
  String get publishedTime => DateFormat("yyyy-MM-dd").format(videoController.video.snippet.publishTime);
  String get description => videoController.video.snippet.description;
  String get youtuberThumbnailUrl => videoController.thumbnailUrl;
  String get youtuberChannelName => videoController.youtuber.value.snippet!.title;
  String? get youtuberSubscribeCount => "구독자 ${videoController.youtuber.value.statistics!.subscriberCount}";
}