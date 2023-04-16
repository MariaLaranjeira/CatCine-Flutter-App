import 'dart:convert';
import 'package:catcine_es/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'media.dart';


class API {

  static Future<String> getInfo(String title) async {
    final client = http.Client();

    final request = http.Request('GET',
        Uri.parse('https://mdblist.p.rapidapi.com/?s=$title&27'))
      ..headers.addAll({
        'X-RapidAPI-Key': '322517c2fcmsh5a7bb5bc63667bap1e25ddjsn621dc7f6ef99',
        'X-RapidAPI-Host': 'mdblist.p.rapidapi.com'
      });


    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    return response.body;
  }


  static Future<List<Media>> makeMedia(String title) async {
    String info = await getInfo(title);
    Map <String, dynamic> json = jsonDecode(info);
    List <dynamic> body = json['search'];
    List <Media> allMedia = body.map((dynamic item) => Media.fromJson(item))
        .toList();
    return allMedia;
  }

  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference mediaDB = FirebaseFirestore.instance.collection('media');

  static addMedia(Media media) async {

    var ref = mediaDB.doc(media.id);
    ref.set({
      'id': media.id,
      'title': media.mediaName,
      'year': media.releaseDate,
      //'score': media.score
    });
  }


  static Future<bool> doesMediaExist(String id) async {
    var ref = await mediaDB.doc(id).get();
    return ref.exists;
  }

  //Stores Media if not found in the db already
  static storeMedia(String title) async {
    List<Media> allMedia = await makeMedia(title);
    for (int i = 0; i < allMedia.length; i++) {
      if (!await doesMediaExist(allMedia[i].id!)) {
        addMedia(allMedia[i]);
      }
    }
  }
  // maybe think about mergin these two in the future? storeMedia <-> updateRemoteList
  static updateRemoteList() async {
    for (int i = 0; i<allLocalMedia.length; i++){
      if (!await doesMediaExist(allLocalMedia[i].id!)) {
        addMedia(allLocalMedia[i]);
      }
    }
  }

  static loadMedia() async {
    QuerySnapshot collection = await mediaDB.get();
    List<Media> allDBMedia = [];
    final documents = collection.docs;
    for (int i = 0; i < documents.length; i++) {
      Media media = Media.api(
          id: documents[i].get('id'),
          mediaName: documents[i].get('title'),
          releaseDate: documents[i].get('year'),
          watchProviders: []
          //score: documents[i].get('score')
      );
      allDBMedia.add(media);
      print ("Just added some media from the db! Purrr. Foi esta oh:");
      print (media.mediaName);
    }
  }
}


