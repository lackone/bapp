import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  String? videoUrl;
  String? cover;
  bool autoPlay;
  bool looping;
  double aspectRatio;

  VideoView({
    Key? key,
    this.videoUrl,
    this.cover,
    this.autoPlay = true,
    this.looping = true,
    this.aspectRatio = 16 / 9,
  }) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(widget.videoUrl ?? '');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Chewie(controller: _chewieController!),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
