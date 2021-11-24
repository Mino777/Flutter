import 'package:flutter_youtube_clone/src/model/statistics.dart';
import 'package:flutter_youtube_clone/src/model/video.dart';
import 'package:flutter_youtube_clone/src/model/youtuber.dart';
import 'package:flutter_youtube_clone/src/repository/youtube_repository.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {

  Video video;

  VideoController({required this.video});

  Rx<Statistics> statistics = Statistics().obs;
  Rx<Youtuber> youtuber = Youtuber().obs;

  @override
  void onInit() async {
    super.onInit();

    Statistics? loadStatistics = await YoutubeRepository.to.getVideoInfoById(
        video.id.videoId);
    statistics(loadStatistics);

    Youtuber? loadYoutuber = await YoutubeRepository.to.getYoutuberInfoById(
        video.snippet.channelId);
    youtuber(loadYoutuber);
  }

  String get viewCountString => "조회수 ${statistics.value.viewCount}회";

  String get thumbnailUrl {
    if (youtuber.value.snippet == null) {
      return "";
    } else {
      return youtuber.value.snippet!.thumbnails.medium.url;
    }
  }
}