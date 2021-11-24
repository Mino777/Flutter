import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_youtube_clone/src/components/video_widget.dart';
import 'package:flutter_youtube_clone/src/controller/youtube_search_controller.dart';
import 'package:get/get.dart';

class YoutubeSearch extends GetView<YoutubeSearchController> {
  const YoutubeSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset("assets/svg/icons/back.svg"),
          onPressed: Get.back,
        ),
        title: TextField(
          decoration: InputDecoration(
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(5))),
          onSubmitted: (value) {
            controller.search(value);
            print(value);
          },
        ),
      ),
      body: Obx(() => controller.youtubeVideoResult.value.items!.length > 0
          ? _searchResultView()
          : _searchHistory()),
    );
  }

  Widget _searchHistory() {
    return ListView(
      children: List.generate(
          controller.history.length,
          (index) => ListTile(
                onTap: () {
                  controller.search(controller.history[index]);
                },
                leading: SvgPicture.asset(
                  "assets/svg/icons/wall-clock.svg",
                  width: 20,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(controller.history[index]),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              )).toList(),
    );
  }

  Widget _searchResultView() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: List.generate(
            controller.youtubeVideoResult.value.items!.length, (index) {
          return GestureDetector(
            onTap: () {
              //page route
              Get.toNamed(
                  "/detail/${controller.youtubeVideoResult.value.items![index].id.videoId}");
            },
            child: VideoWidget(
                video: controller.youtubeVideoResult.value.items![index]),
          );
        }),
      ),
    );
  }
}
