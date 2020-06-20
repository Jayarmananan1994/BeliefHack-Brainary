import 'package:flutter/material.dart';

class NoFavorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.favorite, size: 100, color: Colors.pink),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("You don't have any favorites",
                  style: TextStyle(color: Colors.blue))),
          Text('Tap the heart icon on any lesson'),
          Text('or course to add it on your'),
          Text('favorites list.')
        ],
      ),
    );
  }
}
