import 'package:brainery/commons/my_flutter_app_icons.dart';
import 'package:brainery/model/BraineryLesson.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LessonVideoPlayer extends StatefulWidget {
  final BraineryLesson lesson;
  final Function favoriteHandler;
  final bool isFavorite;
  LessonVideoPlayer(this.lesson, this.favoriteHandler, {this.isFavorite});

  @override
  _LessonVideoPlayerState createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends State<LessonVideoPlayer> {
  double _height, _width;
  VideoPlayerController _playerController;
  Future<void> _videoControllerFuture;
  double _videoProgress = 0;
  String _timeLapseText = "00:00/0:00";
  bool _isFavorite = false;

  @override
  void initState() {
    _isFavorite = widget.isFavorite;
    _playerController = VideoPlayerController.network(widget.lesson.videoUrl);
    _videoControllerFuture = _playerController.initialize();
    _playerController.addListener(() {
      var value = _playerController.value;
      if (value.isPlaying && value.duration != null) {
        var progress = calculateVideoProgress(value.duration, value.position);
        var timeLapse = calculateTimeLapse(value.duration, value.position);
        setState(() {
          _videoProgress = progress;
          _timeLapseText = timeLapse;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Container(
      margin: MediaQuery.of(context).padding,
      height: _height,
      color: Color(0xff2a3e77),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(height: 10),
          IconButton(
              icon: Icon(MyFlutterAppIcons.angle_down, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          videoScreen(),
          SizedBox(height: 30),
          videoControlls(),
        ],
      ),
    );
  }

  videoScreen() {
    return FutureBuilder(
      future: _videoControllerFuture,
      builder: (conext, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
              aspectRatio: 16 / 9, //_playerController.value.aspectRatio,
              child: VideoPlayer(_playerController));
        } else {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  videoControlls() {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 20, right: 20),
      width: _width,
      decoration: BoxDecoration(
          color: Color(0xff1a2c53),
          boxShadow: [
            BoxShadow(color: Color(0xff23365f), blurRadius: 5, spreadRadius: 5)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Now playing", style: TextStyle(color: Colors.white))
                  ])),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.lesson.title,
                      style: TextStyle(color: Colors.white, fontSize: 30))
                ]),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: IconButton(
                  icon:
                      Icon(MyFlutterAppIcons.replay_10, color: Colors.white),
                  onPressed: () {
                    Duration currentPosition =
                        _playerController.value.position;
                    _playerController.seekTo(
                        Duration(seconds: currentPosition.inSeconds - 10));
                  }),
            ),
            Container(
              height: 70,
              width: 70,
              child: RawMaterialButton(
                  shape: CircleBorder(side: BorderSide(width: 0)),
                  fillColor: Colors.blue,
                  child: Icon(
                      (_playerController.value.isPlaying)
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 40),
                  onPressed: () {
                    (_playerController.value.isPlaying)
                        ? _playerController.pause()
                        : _playerController.play();
                    setState(() {});
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: IconButton(
                  icon:
                      Icon(MyFlutterAppIcons.forward_10, color: Colors.white),
                  onPressed: () {
                    Duration currentPosition =
                        _playerController.value.position;
                    _playerController.seekTo(
                        Duration(seconds: currentPosition.inSeconds + 10));
                  }),
            )
          ]),
          SizedBox(height: 20),
          timelapse(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.blueGrey[800],
              value: _videoProgress,
            ),
          ),
          videoFavOption()
        ],
      ),
    );
  }

  Row timelapse() {
    var timeData = _timeLapseText.split("/");
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(timeData[0], style: TextStyle(color: Colors.white)),
          Text(timeData[1], style: TextStyle(color: Colors.white))
        ]);
  }

  double calculateVideoProgress(
      Duration totalDuration, Duration currentPosition) {
    var totalDurInSeconds = totalDuration.inSeconds;
    var currentDurInSeconds = currentPosition.inSeconds;
    if (currentDurInSeconds == 0) {
      return 0;
    }
    return (currentDurInSeconds / totalDurInSeconds);
  }

  String calculateTimeLapse(Duration totalDuration, Duration currentPosition) {
    return "${currentPosition.inMinutes}:${currentPosition.inSeconds} / ${totalDuration.inMinutes}:${totalDuration.inSeconds}";
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  videoFavOption() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            (_isFavorite!=null) ?
            IconButton(icon: Icon( _isFavorite ? Icons.favorite : Icons.favorite_border, size: 35, color: Colors.white), onPressed: () { 
               setState(() {
                 _isFavorite = !_isFavorite;
               });
               widget.favoriteHandler(widget.lesson);
             },) : Container()
          ],
        ));
  }
}
