import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLayout extends StatelessWidget {
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
            Card(
                child: Container(
                    height: _height * 0.3,
                    width: _width * 0.9,
                    color: Colors.grey)),
            SizedBox(height: 20),
            Container(height: 40, width: _width * 0.9, color: Colors.grey),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                            height: 50, width: 70, color: Colors.grey),
                        title: Container(height: 10, color: Colors.grey),
                        subtitle: Container(height: 10, color: Colors.grey),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
