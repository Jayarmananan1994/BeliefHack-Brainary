import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width, _height;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
             Container(margin: EdgeInsets.symmetric(vertical: 10), height: _height*0.1, width: _width * 0.9, color: Colors.grey),
              Container(margin: EdgeInsets.symmetric(vertical: 10), height: _height*0.1, width: _width * 0.9, color: Colors.grey),
               Container(margin: EdgeInsets.symmetric(vertical: 10), height: _height*0.1, width: _width * 0.9, color: Colors.grey),
          ],
        )
      ),
    );
  }
}
