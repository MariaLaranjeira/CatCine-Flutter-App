import 'package:catcine_es/api.dart';
import 'package:catcine_es/main.dart';


class Media {
  String? id;
  String? mediaName;
  int releaseDate;
  int runtime;
  int score;
  String? coverUrl;
  String? description;
  String? imdbId;
  String? traktId;
  String? tmdbId;
  bool movie;
  List<String> watchProviders = [];
  int ageRating;
  String? trailerUrl;
  String? backdropUrl;


  Media(
      this.id,
      this.mediaName,
      this.releaseDate,
      this.runtime,
      this.score,
      this.coverUrl,
      this.description,
      this.imdbId,
      this.traktId,
      this.tmdbId,
      this.movie,
      this.watchProviders,
      this.ageRating,
      this.trailerUrl,
      this.backdropUrl
      );

  Media.api({
    this.id,
    this.mediaName,
    this.releaseDate=0,
    this.runtime=0,
    this.score = 0,
    this.coverUrl,
    this.description,
    this.imdbId,
    this.traktId,
    this.tmdbId,
    this.movie = false,
    required this.watchProviders,
    this.ageRating = 0,
    this.trailerUrl,
    this.backdropUrl
  });

  factory Media.fromJson(Map<String,dynamic> json){
    int year = json['year'] ?? 0;
    int score = json['score_average'] ?? 0;
    return Media.api(
          id: json['id'] as String,
          mediaName: json['title'] as String,
          releaseDate: year,
          watchProviders: []
          //score: score,
          //mediaTime:
          //coverUrl:
          //description:
      );
  }

  toJson(){
    return {
      "Id": id,
      "Name": mediaName,
      "Date": releaseDate,
      //"Duration": runtime,
      //"Score": score,
    };
  }

  static Future<List<Media>> searchTitle(String title) async {
    List<Media> tempMedia = [];
    for (int i = 0; i < allLocalMedia.length; i++){
      if (allLocalMedia[i].mediaName!.contains(title)){
        tempMedia.add(allLocalMedia[i]);
      }
    }
    if (tempMedia.length < 10){
      tempMedia = await API.makeMedia(title);
      updateLocalList(tempMedia);
      API.updateRemoteList();
    }
    return tempMedia;
  }

  static updateLocalList(List<Media> media){

    for (int i=0; i < media.length; i++){
      if (!allLocalMedia.contains(media[i])){
        allLocalMedia.add(media[i]);
      }
    }
  }
}