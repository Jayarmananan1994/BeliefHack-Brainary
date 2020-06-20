class BraineryFavorites {
  List<LessonFav> braineryLessonFav;
  List<CourseFav> braineryCourseFav;

  BraineryFavorites(this.braineryLessonFav, this.braineryCourseFav);
}

class LessonFav{
  String title;
  String imagePreviewUrl;
  String duration;

  LessonFav(this.title, this.imagePreviewUrl, this.duration);
}

class CourseFav{
  String title;
  String imagePreviewUrl;

  CourseFav(this.title, this.imagePreviewUrl);
}