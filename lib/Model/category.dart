import 'media.dart';

class Category {

  List<Media> catMedia;
  String creator;
  String description;
  String title;
  int likes;
  int interactions;
  String backDrop;

  Category(
    this.catMedia,
    this.creator,
    this.description,
    this.title,
    this.likes,
    this.interactions,
    this.backDrop
  );

}
