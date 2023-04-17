import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'media.dart';


class Api {

  Future<String> getInfo(String title) async {
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


  Future<List<Media>> makeMedia(String title) async {
    String info = await getInfo(title);
    Map <String, dynamic> json = jsonDecode(info);
    List <dynamic> body = json['search'];
    List <Media> allMedia = body.map((dynamic item) => Media.fromJson(item))
        .toList();
    return allMedia;
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference mediaDB = FirebaseFirestore.instance.collection('media');

  Future<void> addMedia(Media media) async {

    var ref = mediaDB.doc(media.id);
    ref.set({
      'id': media.id,
      'title': media.mediaName,
      'year': media.mediaDate
    })

        .then((value) => print("Media added"))
        .catchError((error) => print("Failed to add media: $error"));
  }


  Future<bool> doesMediaExist(String id) async {
    var doc = await mediaDB.doc(id).get();
    return doc.exists;
  }


  //Stores Media if not found in the db already
  storeMedia(String title) async {
    List<Media> allMedia = await makeMedia(title);
    for (int i = 0; i < allMedia.length; i++) {
      if (! await doesMediaExist(allMedia[i].id!)) {
        addMedia(allMedia[i]);
      }
    }
  }
}


