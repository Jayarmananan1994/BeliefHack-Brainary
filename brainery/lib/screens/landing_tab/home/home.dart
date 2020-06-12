import 'package:brainery/commons/constants.dart';
import 'package:brainery/commons/ui/brainery_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final VideoPlayerController featuredVideoController =
      VideoPlayerController.network(INTRO_VIDEO_URL);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _sessionPanel(),
          _featuredStudy(),
          //SizedBox(height: 30),
          //Expanded(child: Align(alignment: Alignment.bottomCenter, child: _viewCourseButton())),
          _viewCourseButton()
        ],
      ),
    );
  }

  _sessionPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        pannelHeader('NEXT SESSION', 'VIEW ALL'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Card(
            color: Color(0xff88b3e8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Day One',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Icon(Icons.favorite_border, color: Colors.white)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _featuredStudy() {
    return Column(
      children: <Widget>[
        pannelHeader('FEATURED STUDY', 'VIEW ALL'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: BraineryVideoPlayer(
              controller: featuredVideoController,
              imageProvider: NetworkImage(INTRO_VIDEO_THUMBNAIL)),
        )
      ],
    );
  }

  Padding pannelHeader(String title, String actionTitle) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: TextStyle(
              color: Color(0xff3a4f73),
              fontWeight: FontWeight.w800,
              fontSize: 14),
        ),
        RawMaterialButton(
            onPressed: () {},
            child: Text(
              actionTitle,
              style: TextStyle(color: Colors.blue),
            ))
      ]),
    );
  }

  _viewCourseButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        child: RaisedButton(
            padding: EdgeInsets.all(0),
            textColor: Colors.white,
            onPressed: () {},
            child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff247ae7), Color(0xff089ee2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('VIEW ALL BRAINERY COURSES'),
                    Icon(Icons.arrow_forward)
                  ],
                ))),
      ),
    );
  }

  @override
  void dispose() {
    featuredVideoController.dispose();
    super.dispose();
  }
}
