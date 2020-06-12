import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BraineryVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final ImageProvider imageProvider;
  BraineryVideoPlayer({@required this.controller, this.imageProvider});
  @override
  _BraineryVideoPlayerState createState() => _BraineryVideoPlayerState();
}

class _BraineryVideoPlayerState extends State<BraineryVideoPlayer> {
  Future<void> _initializeVideoPlayerFuture;
  bool shouldPlay = false;
  bool showControl = true;
  bool videoReady = false;
  @override
  void initState() {
    _initializeVideoPlayerFuture = widget.controller.initialize();
    // widget.controller.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (shouldPlay)
        ? FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                videoReady = true;
                return AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: Stack(
                    children: <Widget>[
                      VideoPlayer(widget.controller),
                      GestureDetector(
                        onTap: onTapVideo,
                        child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: (showControl)
                                  ? controllButton()
                                  : Container(),
                            )),
                      )
                    ],
                  ),
                );
              } else {
                return videoPreview();
              }
            },
          )
        : videoPreview();
    // return AspectRatio(
    //   aspectRatio: 16 / 9,
    //   child: (widget.imageProvider==null) ? _blackScreen() : _previewScreen(),
    // );
  }

  videoPreview() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: (widget.imageProvider == null) ? _blackScreen() : _previewScreen(),
    );
  }

  IconButton controllButton() {
    var icontoShow = (widget.controller.value.isPlaying)
        ? Icons.pause_circle_outline
        : Icons.play_circle_outline;
    return IconButton(
      icon: Icon(icontoShow, color: Colors.white, size: 50),
      onPressed: onVideoPlay,
    );
  }

  _blackScreen() {
    return Container(
      color: Colors.black,
      child: _dummyLoader(),
    );
  }

  _previewScreen() {
    return Container(
      //color: Colors.black,
      decoration: BoxDecoration(
        image: DecorationImage(image: widget.imageProvider, fit: BoxFit.cover),
      ),
      child: _dummyLoader(),
    );
  }

  _dummyLoader() {
    return Center(
      child: (shouldPlay)
          ? CircularProgressIndicator()
          : IconButton(
              icon: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 50,
              ),
              onPressed: () {
                setState(() {
                  shouldPlay = true;
                  widget.controller.play();
                });
                // if(videoReady){
                  
                // }
              }),
    );
  }

  void onVideoPlay() {
    setState(() {
      if (widget.controller.value.isPlaying) {
        widget.controller.pause();
      } else {
        widget.controller.play();
        showControl = false;
      }
    });
  }

  void onTapVideo() {
    setState(() {
      showControl = !showControl;
    });
  }
}
