import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  VideoPlayerController? videoController;
  final count = 0.obs;
  RxBool isPlaying = false.obs;
  RxBool isVideoLoading = false.obs;

  @override
  void onInit() {
    initializeVideoPlayer();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initializeVideoPlayer() async {
    isVideoLoading.value = false;
    // String videoUrl = await getVideoUrl('AveoGPT.MP4');
    videoController = VideoPlayerController.networkUrl(Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'))
      ..initialize().then((_) {
        isPlaying.value = true;
        isVideoLoading.value = true;
        videoController!.play();
      });
  }

  Future<String> getVideoUrl(String videoFileName) async {
    isVideoLoading.value = false;
    Reference reference =
        FirebaseStorage.instance.ref().child("videos/$videoFileName");
    String downloadURL = await reference.getDownloadURL();
    return downloadURL;
  }

  void increment() => count.value++;
}
