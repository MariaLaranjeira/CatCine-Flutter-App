import 'package:catcine_es/api.dart';
import 'package:catcine_es/main.dart';


class Media {
  String id;
  String? mediaName;
  int? releaseDate;
  int? runtime;
  int? score;
  String? coverUrl;
  String? description;
  String? imdbId;
  int? traktId;
  int? tmdbId;
  bool movie;
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
    this.id = '',
    this.mediaName,
    this.releaseDate,
    this.runtime,
    this.score,
    this.coverUrl,
    this.description,
    this.imdbId,
    this.traktId,
    this.tmdbId,
    this.movie = false,
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
        id: json['id'] as String,
        mediaName: json['title'] as String?,
        releaseDate: json['year'],
        watchProviders: [],
        score: json['score_average'] ?? 0,
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

  updateInfo(Map<String, dynamic> fullInfo) {
    bool _movie = false;
    if (fullInfo['type'] == 'movie') _movie == true;
    List<dynamic> watchProviders_ = fullInfo['watch_providers'] ?? [];
    description = fullInfo['description'] as String?;
    runtime = fullInfo['runtime'] ?? 0;
    imdbId = fullInfo['imdbid'] as String?;
    traktId = fullInfo['traktid'] ?? 0;
    tmdbId = fullInfo['tmdbid'] ?? 0;
    movie = _movie;
    ageRating = fullInfo['age_rating'] ?? 0;
    trailerUrl = fullInfo['trailer'] as String?;
    backdropUrl = fullInfo['backdrop'] as String?;
    coverUrl = fullInfo['poster'] as String?;
    for (Map<String, dynamic> provider in watchProviders_) {
      for (final i in provider.keys) {
          watchProviders.add(i ?? '');
      }
    }
  }

  static Future<List<Media>> searchTitle(String title) async {
    List<Media> tempMedia = [];
    for (var media in allLocalMedia.values){
      if (allLocalMedia.isEmpty) break;
      if (media.mediaName!.toLowerCase().contains(title.toLowerCase()) ||
          media.mediaName!.toUpperCase().contains(title.toUpperCase())){
        tempMedia.add(media);
      }
    }
    if (tempMedia.length < 10){
      tempMedia = await API.makeMedia(title);
      updateLocalList(tempMedia);
    }
    return tempMedia;
  }

  static updateLocalList(List<Media> mediaList){

    for (var media in mediaList){
      if (!allLocalMedia.values.contains(media)){
        allLocalMedia[media.id] = media;
      }
    }
  }
}