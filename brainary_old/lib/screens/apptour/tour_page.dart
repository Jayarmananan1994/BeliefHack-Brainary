import 'package:brainary/screens/apptour/slide_page_one.dart';
import 'package:brainary/screens/apptour/slide_page_two.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TourPage extends StatefulWidget {
  static const String PATH = "/tour-page";
  final VideoPlayerController controller;

  TourPage({@required this.controller});

  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    return Scaffold(
      backgroundColor: Color(0xff2469c6),
      body: Stack(
        children: <Widget>[
          PageView(
            //physics: NeverScrollableScrollPhysics(),
            onPageChanged: _onchanged,
            scrollDirection: Axis.horizontal,
            controller: _controller,
            children: <Widget>[SlidePageOne(controller: widget.controller), SlidePageTwo()],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[slideIndicators()],
          )
        ],
      ),
    );
  }

  slideIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(2, (int index) {
        return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 10,
            width: (index == _currentPage) ? 30 : 10,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: (index == _currentPage)
                    ? Colors.blue
                    : Colors.blue.withOpacity(0.5)));
      }),
    );
  }

  void _onchanged(int index) {
   
    setState(() {
      _currentPage = index;
       if(widget.controller.value.isPlaying && index==1){
          widget.controller.pause();
        }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
