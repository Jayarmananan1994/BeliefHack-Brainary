import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IntroVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  IntroVideoPlayer({@required this.controller});

  @override
  _IntroVideoPlayerState createState() => _IntroVideoPlayerState();
}

class _IntroVideoPlayerState extends State<IntroVideoPlayer> {
  //VideoPlayerController _controller;
  //Future<void> _initializeVideoPlayerFuture;
  bool showControllButton = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: Stack(
        children: <Widget>[
          VideoPlayer(widget.controller),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              child: (showControllButton)
                  ? Center(
                      child: _controllButton(),
                    )
                  : Container(),
            ),
            onTap: () {
              setState(() {
                showControllButton = !showControllButton;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _controllButton() {
    return IconButton(
        icon: Icon(
            (widget.controller.value.isPlaying)
                ? Icons.pause_circle_outline
                : Icons.play_circle_filled,
            size: 35),
        onPressed: () {
          setState(() {
            if (widget.controller.value.isPlaying) {
              widget.controller.pause();
            } else {
              showControllButton = false;
              widget.controller.play();
            }
          });
        });
  }
}
