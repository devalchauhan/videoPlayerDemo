import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:video_player_demo/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;

  @override
  void onInit() {
    checkLogin();
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

  void checkLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if (auth.currentUser != null) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.AUTH);
      }
    });
  }
}
