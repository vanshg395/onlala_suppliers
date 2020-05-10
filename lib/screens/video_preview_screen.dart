import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPreviewScreen extends StatefulWidget {
  @override
  _VideoPreviewScreenState createState() => _VideoPreviewScreenState();

  final String videoUrl;

  VideoPreviewScreen(this.videoUrl);
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    if (widget.videoUrl.contains('http')) {
      _videoPlayerController1 = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController1,
              aspectRatio: _videoPlayerController1.value.aspectRatio,
              autoPlay: true,
              looping: false,
            );
          });
        });
    } else {
      _videoPlayerController1 =
          VideoPlayerController.file(File(widget.videoUrl))
            ..initialize().then((_) {
              setState(() {
                _chewieController = ChewieController(
                  videoPlayerController: _videoPlayerController1,
                  aspectRatio: _videoPlayerController1.value.aspectRatio,
                  autoPlay: true,
                  looping: false,
                );
              });
            });
    }

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('>>>>>>>>>');
    print(_videoPlayerController1.value.aspectRatio);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Video Preview',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: _chewieController == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : Chewie(
                  controller: _chewieController,
                ),
        ),
      ),
    );
  }
}
