import 'media.dart';

class Category {

  String title;

  List<Media> catMedia;
  String creator;
  String description;
  int likes;
  int interactions;
  List<List<int>> updown;
  //String backDrop;

  Category(
    this.catMedia,
    this.creator,
    this.description,
    this.title,
    this.likes,
    this.interactions,
    this.updown,
    //this.backDrop
  );

  Category.fromFirebase({
    this.title = "",
    this.creator = "",
    this.catMedia = const [],
    this.description = "",
    //this.backDrop = "",
    this.interactions = 1,
    this.likes = 1,
    this.updown = const [[]],
  });

  factory Category.fromJson(Map<String,dynamic> json){

    var title = json['title'] ?? '';
    var creator = json['creator'] ?? '';
    var description = json['description'] ?? "";
    var backDrop = json['backDrop'] ?? "";
    var likes = json['likes'] ?? 1;
    var interactions = json['interactions'] ?? 1;

    return Category.fromFirebase(
      title: title,
      creator: creator,
      description: description,
      //backDrop: backDrop,
      likes: likes,
      interactions: interactions
    );
  }

  toJson() {
    return {
      "title": title,
      "creator": creator,
      "description": description,
      //"bakDrop": backDrop,
      "likes": likes,
      "interactions": interactions
    };
  }

}
