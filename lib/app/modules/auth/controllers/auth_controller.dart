import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aveoauth/aveoauth.dart';
import 'package:video_player_demo/app/utils/snakbar.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController
    with GoogleLogin, FirebaseEmailLogin {
  //TODO: Implement AuthController
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isSignUpMode = false.obs;
  RxBool isForgetPasswordMode = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void onInit() {
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

  void resetPassword() => resetPasswordWithFirebaseEmail(
        Get.context!,
        firebaseInstance: FirebaseAuth.instance,
        onSuccess: (message) {
          FocusScope.of(Get.context!).unfocus();
          snackBar(message, Get.context!);
          isForgetPasswordMode.value = false;
        },
        onError: (error) {
          snackBar(error, Get.context!);
        },
        email: emailController.text,
      );

  void signUp() => signUpWithFirebaseEmail(
        Get.context!,
        firebaseInstance: FirebaseAuth.instance,
        onSuccess: (message, cred) {
          FocusScope.of(Get.context!).unfocus();
          snackBar(message, Get.context!);
          Get.offAllNamed(Routes.HOME);
          isSignUpMode.value = false;
        },
        onError: (error) {
          snackBar(error, Get.context!);
        },
        email: emailController.text,
        password: passwordController.text,
      );

  void signInWithEmailPassword() => signInWithFirebaseEmail(
        Get.context!,
        firebaseInstance: FirebaseAuth.instance,
        onSuccess: (message, cred) {
          snackBar(message, Get.context!);
          FocusScope.of(Get.context!).unfocus();
          Get.offAllNamed(Routes.HOME);
        },
        onError: (error) {
          snackBar(error, Get.context!);
        },
        email: emailController.text,
        password: passwordController.text,
      );

  void googleSignIn() =>signInWithGoogle(Get.context!,
      firebaseInstance: FirebaseAuth.instance,
      onSuccess: (message, cred) {
        if (kDebugMode) {
          print(cred.user);
        }
        FocusScope.of(Get.context!).unfocus();
        snackBar(message, Get.context!);
        Get.offAllNamed(Routes.HOME);
      }, onError: (error) {
        snackBar(error, Get.context!);
      });
}
