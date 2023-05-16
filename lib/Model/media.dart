import 'package:catcine_es/api.dart';
import 'package:catcine_es/main.dart';


class Media {
  String id;
  String mediaName;
  int releaseDate;
  int runtime;
  int score;
  String coverUrl;
  String description;
  String imdbId;
  int traktId;
  int tmdbId;
  bool movie;
  List<String> watchProviders = [];
  int ageRating;
  String trailerUrl;
  String backdropUrl;
  bool isInFirebase;



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
      this.backdropUrl,
      this.isInFirebase,
      );

  Media.api({
    this.id = '',
    this.mediaName = '',
    this.releaseDate = 1,
    this.runtime = 1,
    this.score = 1,
    this.coverUrl = '',
    this.description = '',
    this.imdbId = '',
    this.traktId = 1,
    this.tmdbId = 1,
    this.movie = false,
    this.watchProviders = const [],
    this.ageRating = 1,
    this.trailerUrl = '',
    this.backdropUrl = '',
    this.isInFirebase = false,
  });

  factory Media.fromJson(Map<String,dynamic> json){
    bool type = false;
    if (json['type'] == 'movie'){
      type = true;
    }

    var id = json['id'] ?? '';
    var mediaName = json['title'] ?? '';
    var releaseDate = json['year'] ?? 1;
    //watchProviders: [];
    var score = json['score_average'] ?? 1;
    var runtime = json['runtime'] ?? 1;
    var coverUrl = json['poster'] ?? '';
    var description = json['description'] ?? '';
    var imdbId = json['imdbid'] ?? '';
    var traktId = json['traktid'] ?? 1;
    var tmdbId = json['tmdbid'] ?? 1;
    var ageRating = json['age_rating'] ?? 1;
    var trailerUrl = json['trailer'] ?? '';
    var backdropUrl = json['backdrop'] ?? '';

    return Media.api(
        id: id,
        mediaName: mediaName,
        releaseDate: releaseDate,
        //watchProviders: [],
        score: score,
        runtime: runtime,
        coverUrl: coverUrl,
        description: description,
        imdbId: imdbId,
        traktId: traktId,
        tmdbId: tmdbId,
        movie: type,
        ageRating: ageRating,
        trailerUrl: trailerUrl,
        backdropUrl: backdropUrl,
        isInFirebase: false,
    );
  }

  toJson(){
    return {
      "id": id,
      "title": mediaName,
      "year": releaseDate,
      //"Duration": runtime,
      //"Score": score,
    };
  }

  updateInfo(Map<String, dynamic> fullInfo) {
    bool _movie = false;
    if (fullInfo['type'] == 'movie') _movie == true;
    //List<dynamic> watchProviders_ = fullInfo['watch_providers'] ?? [];
    description = fullInfo['description'] ?? '';
    runtime = fullInfo['runtime'] ?? 1;
    imdbId = fullInfo['imdbid'] ?? '';
    traktId = fullInfo['traktid'] ?? 1;
    tmdbId = fullInfo['tmdbid'] ?? 1;
    movie = _movie;
    ageRating = fullInfo['age_rating'] ?? 1;
    trailerUrl = fullInfo['trailer'] ?? '';
    backdropUrl = fullInfo['backdrop'] ?? '';
    coverUrl = fullInfo['poster'] ?? '';
  }

  static Future<List<Media>> searchTitle(String title) async {
    List<Media> tempMedia = [];
    for (var media in allLocalMedia.values){
      if (media.mediaName.toLowerCase().contains(title.toLowerCase()) ||
          media.mediaName.toUpperCase().contains(title.toUpperCase())){
        tempMedia.add(media);
      }
    }
    if (tempMedia.isEmpty){
      tempMedia = await API.makeMedia(title);
      updateLocalList(tempMedia);
    }
    else if (tempMedia.length < 10) {
      List<Media> temp = await API.makeMedia(title);
      updateLocalList(temp);
      for (var elem in temp) {
        if (tempMedia.any((element) => elem.id == element.id)) {
          continue;
        }
        else {
          tempMedia.add(elem);
        }
      }
    }
    return tempMedia;
  }

  static updateLocalList(List<Media> mediaList){
    for (var media in mediaList){
      if (!allLocalMedia.keys.any((element) => element == media.id)){
        allLocalMedia[media.id] = media;
      }
    }
  }
}