import 'package:brainery/model/BraineryFavorites.dart';
import 'package:brainery/screens/landing_tab/favorites/fav_shimmer_layout.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  BraineryUserService _braineryUserService = locator<BraineryUserService>();
  Color _themeColor;

  @override
  Widget build(BuildContext context) {
    _themeColor = Theme.of(context).primaryColor;
    return FutureBuilder<BraineryFavorites>(
      future: _braineryUserService.getUserFavotires(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var favorites = snapshot.data;
          var lessons = favorites.braineryLessonFav;
          var courses = favorites.braineryCourseFav;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _title('LESSONS'),
              Expanded(child: _generateLessonFavList(lessons)),
               _title('COURSES'),
              Expanded(child: _generateCourseFavList(courses))
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error fetching data');
        } else {
          return FavShimmerLayout();
        }
      },
    );
  }

  _generateLessonFavList(lessons) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lessons[index].title),
            subtitle: Text(lessons[index].duration),
            leading: Image.network(lessons[index].imagePreviewUrl),
          );
        },
        separatorBuilder: (ctx, i) =>
            Divider(thickness: 1, indent: 15, endIndent: 15),
        itemCount: lessons.length);
  }

  _generateCourseFavList(List<CourseFav> courses) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(courses[index].title),
            leading: Image.network(courses[index].imagePreviewUrl),
          );
        },
        separatorBuilder: (ctx, i) =>
            Divider(thickness: 1, indent: 15, endIndent: 15),
        itemCount: courses.length);
  }

  _title(String title) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Text(title,
            style: TextStyle(
                color: _themeColor,
                fontSize: 16,
                fontWeight: FontWeight.w800)));
  }
}
