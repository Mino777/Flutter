import 'package:flutter_youtube_clone/src/model/statistics.dart';
import 'package:flutter_youtube_clone/src/model/youtube_video_result.dart';
import 'package:flutter_youtube_clone/src/model/youtuber.dart';
import 'package:get/get.dart';

class YoutubeRepository extends GetConnect {
  // GetConnect => API 통신 관련
  static YoutubeRepository get to => Get.find();

  @override
  void onInit() {
    super.onInit();

    httpClient.baseUrl = "https://www.googleapis.com";
  }

  Future<YoutubeVideoResult?> loadVideos(String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&channelId=UCbMGBIayK26L4VaFrs5jyBw&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyB6uZTo5BxOSJOQ6BKExfc-Q0ZrZUWRNxs&pageToken=$nextPageToken";

    final response = await get(url);

    if (response.status.hasError) {
      print(Future.error(response.hasError));
      return Future.error(response.hasError);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        print(YoutubeVideoResult.fromJson(response.body));
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }

  Future<YoutubeVideoResult?> search(
      String searchKeyword, String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&channelId=UCbMGBIayK26L4VaFrs5jyBw&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyB6uZTo5BxOSJOQ6BKExfc-Q0ZrZUWRNxs&pageToken=$nextPageToken&q=$searchKeyword";

    final response = await get(url);

    if (response.status.hasError) {
      return Future.error(response.hasError);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }

  Future<Statistics?> getVideoInfoById(String videoId) async {
    String url =
        "/youtube/v3/videos?part=statistics&key=AIzaSyB6uZTo5BxOSJOQ6BKExfc-Q0ZrZUWRNxs&id=$videoId";
    final response = await get(url);

    if (response.status.hasError) {
      return Future.error(response.hasError);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        return Statistics.fromJson(data["statistics"]);
      }
    }
  }

  Future<Youtuber?> getYoutuberInfoById(String channelID) async {
    String url =
        "/youtube/v3/channels?part=statistics,snippet&key=AIzaSyB6uZTo5BxOSJOQ6BKExfc-Q0ZrZUWRNxs&id=$channelID";
    final response = await get(url);

    if (response.status.hasError) {
      return Future.error(response.hasError);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        return Youtuber.fromJson(data);
      }
    }
  }
}
