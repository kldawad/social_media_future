import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String vid;

  VideoScreen({required this.vid});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.vid);
    await Future.wait([_videoPlayerController!.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController!.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? Chewie(
            controller: _chewieController!,
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
