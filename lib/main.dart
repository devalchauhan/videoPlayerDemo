import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_demo/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? const FirebaseOptions(
            apiKey: 'AIzaSyBBFFh2LEBbn3_I9GGP5yJJamP-Jl_P_ck',
            appId: '1:224306600364:android:9d3b485e0a55b07c024209',
            messagingSenderId: '224306600364',
            projectId: 'videoplayerdemo-aeb66',
            storageBucket: "videoplayerdemo-aeb66.appspot.com",
          )
        : const FirebaseOptions(
            apiKey: 'apiKey',
            appId: 'appId',
            messagingSenderId: 'messagingSenderId',
            projectId: 'projectId',
          ),
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
