import 'package:catcine_es/api.dart';
import 'package:catcine_es/main.dart';


class Media {
  String? id;
  String? mediaName;
  int? releaseDate;
  int? runtime;
  int? score;
  String? coverUrl;
  String? description;
  String? imdbId;
  int? traktId;
  int? tmdbId;
  bool? movie;
  List<String> watchProviders = [];
  int? ageRating;
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
    this.releaseDate,
    this.runtime,
    this.score,
    this.coverUrl,
    this.description,
    this.imdbId,
    this.traktId,
    this.tmdbId,
    this.movie,
    required this.watchProviders,
    this.ageRating,
    this.trailerUrl,
    this.backdropUrl
  });

  factory Media.fromJson(Map<String,dynamic> json){
    bool type = false;
    if (json['type'] == 'movie'){
      type = true;
    }
    return Media.api(
        id: json['id'] as String?,
        mediaName: json['title'] as String?,
        releaseDate: json['year'],
        watchProviders: [],
        //score: score,
        runtime: json['runtime'],
        coverUrl: json['poster'] as String?,
        description: json['description'] as String?,
        imdbId: json['imdbid'] as String?,
        traktId: json['traktid'],
        tmdbId: json['tmdbid'],
        movie: type,
        ageRating: json['age_rating'],
        trailerUrl: json['trailer'] as String?,
        backdropUrl: json['backdrop'] as String?
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
      if (allLocalMedia[i].mediaName!.toLowerCase().contains(title.toLowerCase()) ||
          allLocalMedia[i].mediaName!.toUpperCase().contains(title.toUpperCase())){
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