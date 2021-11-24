import 'package:flutter_youtube_clone/src/model/statistics.dart';
import 'package:flutter_youtube_clone/src/model/video.dart';

class Youtuber {
  Youtuber({
    this.snippet,
    this.statistics,
  });

  Snippet? snippet;
  Statistics? statistics;

  factory Youtuber.fromJson(Map<String, dynamic> json) => Youtuber(
    snippet: Snippet.fromJson(json["snippet"]),
    statistics: Statistics.fromJson(json["statistics"]),
  );
}