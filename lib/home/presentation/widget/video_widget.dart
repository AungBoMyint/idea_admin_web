import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui.dart';
import 'package:video_player/video_player.dart';

/* class VideoWidget extends StatelessWidget {
  final String videoUrl;

  VideoWidget({required this.videoUrl}) {
    // Register the video element
    platformViewRegistry.registerViewFactory(
      videoUrl,
      (int viewId) => html.VideoElement()
        ..src = videoUrl
        ..autoplay = true
        ..controls = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: videoUrl);
  }
}
 */

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  const VideoWidget({super.key, required this.videoUrl});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
