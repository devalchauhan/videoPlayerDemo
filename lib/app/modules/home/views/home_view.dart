import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_demo/app/modules/home/views/widget/player_widget.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AveoVideoPlayer'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.AUTH);
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Obx(
            () => !controller.isVideoLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      AspectRatio(
                        aspectRatio:
                            controller.videoController!.value.aspectRatio / 0.8,
                        child: VideoPlayer(controller.videoController!),
                      ),
                      Center(
                        child: IconButton(
                          icon: controller.isPlaying.value && !controller.videoController!.value.isCompleted
                              ? const Icon(Icons.pause)
                              : const Icon(Icons.play_arrow),
                          onPressed: () {
                            if (controller.isPlaying.value) {
                              controller.isPlaying.value = false;
                              controller.videoController!.pause();
                            } else {
                              controller.isPlaying.value = true;
                              controller.videoController!.play();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
