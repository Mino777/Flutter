import 'package:flutter/material.dart';
import 'package:flutter_youtube_clone/src/components/custom_appbar.dart';
import 'package:flutter_youtube_clone/src/components/video_widget.dart';
import 'package:flutter_youtube_clone/src/controller/home_controller.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => CustomScrollView(
          controller: _controller.scrollController,
          slivers: [
            SliverAppBar(
              title: CustomAppBar(),
              floating: true,
              snap: true,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return GestureDetector(
                child: VideoWidget(video: _controller.youtubeResult.value.items![index]),
                onTap: () {
                  Get.toNamed("/detail/${_controller.youtubeResult.value.items![index].id.videoId}");
                },
              );
            }, childCount: _controller.youtubeResult.value.items == null ? 0 :
                _controller.youtubeResult.value.items!.length))
          ],
        ),
      ),
    );
  }
}
