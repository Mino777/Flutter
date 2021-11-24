import 'package:flutter_youtube_clone/src/model/video.dart';

class YoutubeVideoResult {
  int? totalResults;
  int? resultsPerPage;
  String? nextPageToken;
  List<Video>? items;

  YoutubeVideoResult({
    this.totalResults,
    this.resultsPerPage,
    this.nextPageToken,
    this.items,
  });

  factory YoutubeVideoResult.fromJson(Map<String, dynamic> json) =>
      YoutubeVideoResult(
          totalResults: json["pageInfo"]["totalResults"],
          resultsPerPage: json["pageInfo"]["resultsPerPage"],
          nextPageToken: json["nextPageToken"] ?? "",
          items: List<Video>.from(json["items"].map((data) => Video.fromJson(data))));
}