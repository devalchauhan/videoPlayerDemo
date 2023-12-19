import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController? _videoPlayerController;
  var _isLoading = true;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  void _initPlayer() async {
    final url = await downloadVideoURL(widget.name);
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    initializeVideoPlayerFuture = _videoPlayerController!.initialize();
    _isLoading = false;
    setState(() {});
  }

  Future<String> downloadVideoURL(String videoFile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      String downloadURL =
          await storage.ref('videos/AveoGPT.MP4').getDownloadURL();
      // ignore: avoid_print
      print(downloadURL);
      return downloadURL;
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator();
    }
    return FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController!),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
