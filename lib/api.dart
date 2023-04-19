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

  static getTMTRInfo(String id, String searchType, String mediaType) async {
    final client = http.Client();

    final request = http.Request('GET',
        Uri.parse('https://mdblist.p.rapidapi.com/?$searchType=$id&m=$mediaType'))
      ..headers.addAll({
        'X-RapidAPI-Key': '322517c2fcmsh5a7bb5bc63667bap1e25ddjsn621dc7f6ef99',
        'X-RapidAPI-Host': 'mdblist.p.rapidapi.com'
      });


    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    //print(response.body);
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
      info = await getTMTRInfo(id, searchType, mediaType);
    }
    Map <String, dynamic> json = jsonDecode(info);
    return json;
  }

  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference mediaDB = FirebaseFirestore.instance.collection(
      'media');

  static addMedia(Media media) async {
    String type = 'show';
    if (media.movie) {
      type = 'movie';
    }

    var ref = mediaDB.doc(media.id);

    ref.set({
      'id': media.id,
      'title': media.mediaName,
      'year': media.releaseDate,
      'runtime': media.runtime,
      'poster': media.coverUrl,
      'description': media.description,
      'imdbid': media.imdbId,
      'traktid': media.traktId,
      'tmdbid': media.tmdbId,
      'type': type,
      'age_rating': media.ageRating,
      'trailer': media.trailerUrl,
      'backdrop': media.backdropUrl,
      'score': media.score
    },
    SetOptions(merge: true),
    );
  }

  static updateMedia(Media media) async {
    String type = 'show';
    if (media.movie) {
      type = 'movie';
    }

    var ref = mediaDB.doc(media.id);

    ref.update({
      'runtime': media.runtime,
      'poster': media.coverUrl,
      'description': media.description,
      'imdbid': media.imdbId,
      'traktid': media.traktId,
      'tmdbid': media.tmdbId,
      'type': type,
      'age_rating': media.ageRating,
      'trailer': media.trailerUrl,
      'backdrop': media.backdropUrl,
      'score': media.score
    }
    );
  }


  static Future<bool> doesMediaExist(String id) async {
    var ref = await mediaDB.doc(id).get();
    return ref.exists;
  }

  static Future<bool> isMediaInfoComplete(String id) async {

    bool res = false;
    mediaDB
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        var aux = data as Map<String, dynamic>;
        print(aux);
        res = aux.containsKey('poster');
      }
    });

    return res;

    //var doc = mediaDB.doc(id);
    /*
    if(await doc.get().then((value) {
      try {
        final test = value.get('poster');
        return true;
      } on StateError catch (e){
        return false;
      }
    })) {
      return true;
    }
    return false;
    */
  }

  //Stores Media if not found in the db already
  static storeMedia(String title) async {
    List<Media> allMedia = await makeMedia(title);
    for (var media in allMedia) {
      if (!await doesMediaExist(media.id)) {
        addMedia(media);
      }
    }
  }

  // maybe think about merging these two in the future? storeMedia <-> updateRemoteList
  static updateRemoteList() async {

    for (var media in allLocalMedia.values) {
      if (!await isMediaInfoComplete(media.id)) {
        await mediaSpecificUpdate(media);
        updateMedia(media);
      }
    }
  }

  static Future<Map<String ,Media>> loadMedia() async {
    Map<String, Media> allDBMedia = {};

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
          Media media = Media.api(
              id: res['id'],
              mediaName: res['title'] ?? "",
              releaseDate: res['year'] ?? 0,
              //
            //
            // watchProviders: []
            //score: documents[i].get('score')
          );

          allDBMedia[media.id] = media;
          print ("Just added some media from the db! Purrr. Foi esta oh:");
          print (media.mediaName);
        }
      });
    }
    return allDBMedia;
  }

  /*
  static searchById() async{
    final query = await mediaDB.get();
    for (var doc in query.docs) {

    }
  }
  */

  static mediaSpecificUpdate(Media media) async {
    String mediaType;
    for (var key in allLocalMedia.keys) {

      if (allLocalMedia[key]!.movie) {
        mediaType = 'movie';
      } else {
        mediaType = 'show';
      }

      if (allLocalMedia[key]!.id == media.id) {

        Map<String, dynamic> infoMap;

        if (allLocalMedia[key]!.id[1] == 't') {
          infoMap = await API.fullInfo(true,allLocalMedia[key]!.id, 'i' , mediaType);
        } else {
          infoMap = await API.fullInfo(false,allLocalMedia[key]!.id.substring(2), 't',mediaType);
        }

        allLocalMedia[key]!.updateInfo(infoMap);
        break;
      }
    }
  }
}


