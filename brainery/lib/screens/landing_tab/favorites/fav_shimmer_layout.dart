import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(15),
                height: 15,
                width: 100,
                color: Colors.grey),
            //SizedBox(height: 10),
            dummyFavlist(),
            //SizedBox(height: 10),
            Container(
                margin: EdgeInsets.all(15),
                height: 15,
                width: 100,
                color: Colors.grey),
            dummyFavlist(),
          ],
        ),
      ),
    );
  }

  dummyFavlist() {
    return Expanded(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(height: 50, width: 70, color: Colors.grey),
                title: Container(height: 10, color: Colors.grey),
                subtitle: Container(height: 10, color: Colors.grey),
              );
            }));
  }
}
