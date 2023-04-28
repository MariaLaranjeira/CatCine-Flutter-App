import 'dart:convert';
import 'dart:core';
import 'package:catcine_es/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'media.dart';


class API {

  static Future<String> getInfo(String title,String searchType) async {
    final client = http.Client();

    final request = http.Request('GET',
        Uri.parse('https://mdblist.p.rapidapi.com/?$searchType=$title'))
      ..headers.addAll({
        'X-RapidAPI-Key': '322517c2fcmsh5a7bb5bc63667bap1e25ddjsn621dc7f6ef99',
        'X-RapidAPI-Host': 'mdblist.p.rapidapi.com'
      });

    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    return response.body;
  }

  static getTRInfo(String id, String searchType, String mediaType) async {
    final client = http.Client();

    final request = http.Request('GET',
        Uri.parse('https://mdblist.p.rapidapi.com/?$searchType=$id&m=$mediaType'))
      ..headers.addAll({
        'X-RapidAPI-Key': '322517c2fcmsh5a7bb5bc63667bap1e25ddjsn621dc7f6ef99',
        'X-RapidAPI-Host': 'mdblist.p.rapidapi.com'
      });


    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);
    return response.body;
  }


  static Future<List<Media>> makeMedia(String title) async {
    String info = await getInfo(title,'s');
    Map<String, dynamic> json = jsonDecode(info);
    List<dynamic> body = json['search'] ?? [];
    List<Media> allMedia = body.map((dynamic item) => Media.fromJson(item))
        .toList();
    return allMedia;
  }

  static Future<Map<String, dynamic>> fullInfo(bool isIMDB, String id, String searchType, String mediaType) async {
    String info;
    if (isIMDB) {
      info = await getInfo(id, searchType);
    } else {
      info = await getTRInfo(id, searchType, mediaType);
    }
    Map <String, dynamic> json = jsonDecode(info);
    return json;
  }

  static CollectionReference mediaDB = FirebaseFirestore.instance.collection(
      'media');


  static addMedia(Media media) async {

    String type = 'show';
    if (media.movie) {
      type = 'movie';
    }

    var ref = mediaDB.doc(media.id);

    media.isInFirebase = true;

    ref.set({
      'id': media.id,
      'title': media.mediaName,
      'year': media.releaseDate,
      'runtime': 1,
      'poster': "",
      'description': "",
      'imdbid': "",
      'traktid': 1,
      'tmdbid': 1,
      'type': type,
      'age_rating': 1,
      'trailer': "",
      'backdrop': "",
      'score': 1
    },
    SetOptions(merge: true),
    );
  }

  static updateMedia(Media media) async {

    var ref = mediaDB.doc(media.id);

    ref.update({
      'runtime': media.runtime,
      'poster': media.coverUrl,
      'description': media.description,
      'imdbid': media.imdbId,
      'traktid': media.traktId,
      'tmdbid': media.tmdbId,
      'age_rating': media.ageRating,
      'trailer': media.trailerUrl,
      'backdrop': media.backdropUrl,
      'score': media.score
    });

  }


  static Future<bool> doesMediaExist(String id) async {
    var ref = await mediaDB.doc(id).get();
    return ref.exists;


  }

  static Future<bool> isMediaInfoComplete(String id) async {

    bool res = true;
    await mediaDB.doc(id).get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        var aux = data as Map<String, dynamic>;
        res = !(aux['poster'] == '' && aux['description'] == '' && aux['backdrop'] == '');
      }
    });

    return res;
  }

  //Stores Media if not found in the db already
  static storeMedia() async {
    for (var media in allLocalMedia.values) {
      if (!media.isInFirebase) {
        addMedia(media);
      }
    }
  }

  static updateRemoteList(List<Media> list) async {
    for (var media in list) {
      await mediaDB.doc(media.id).get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();
          var aux = data as Map<String, dynamic>;

          if((aux['poster'] == '' && aux['description'] == '' && aux['backdrop'] == '')) {
            await mediaSpecificUpdate(media);
            updateMedia(media);
          }
        }
      });
    }
  }

  static loadMedia() async {

    List<String> _userKey = [];
    final query = await mediaDB.get();

    for (var doc in query.docs) {
      _userKey.add(doc.id);
    }

    for (String _key in _userKey){
      mediaDB
          .doc(_key)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();
          var res = data as Map<String, dynamic>;

          bool _movie = false;
          if (res['type'] == 'movie') {
            _movie = true;
          }

          Media media = Media.api(
              id: res['id'],
              mediaName: res['title'] ?? "",
              releaseDate: res['year'] ?? 0,
              score: res['score'] ?? 0,
              runtime: res['runtime'] ?? 0,
              coverUrl: res['poster'] ?? "",
              description: res['description'] ?? "",
              imdbId: res['imdbid'] ?? "",
              traktId: res['traktid'] ?? 0,
              tmdbId: res['tmdbid'] ?? 0,
              movie: _movie,
              ageRating: res['age_rating'] ?? 0,
              trailerUrl: res['trailer'] ?? "",
              backdropUrl: res['backdrop'] ?? "",
              isInFirebase: true,
          );

          allLocalMedia[media.id] = media;
        }
      });
    }
  }


  static mediaSpecificUpdate(Media media) async {
    String mediaType;

    if (allLocalMedia[media.id]!.movie) {
        mediaType = 'movie';
      } else {
        mediaType = 'show';
      }

    Map<String, dynamic> infoMap;

    if (media.id[1] == 't') {
      infoMap =
      await API.fullInfo(true, media.id, 'i', mediaType);
    } else {
      infoMap =
      await API.fullInfo(false, media.id.substring(2), 't', mediaType);
    }
    media.updateInfo(infoMap);
  }
}


