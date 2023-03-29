import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'media.dart';


class Api {

  Future<String> getInfo(String title) async {
    final client = http.Client();

    final request = http.Request('GET',
        Uri.parse('https://mdblist.p.rapidapi.com/?s=$title'))
      ..headers.addAll({
        'X-RapidAPI-Key': 'd681c42be1msha8325a6eba62bd0p10fe15jsn10d36805b704',
        'X-RapidAPI-Host': 'mdblist.p.rapidapi.com'
      });


    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    return response.body; // Return the response body as a string
  }


  Future<List<Media>> makeMedia(String title) async{
    String info = await getInfo(title);
    Map <String, dynamic> json = jsonDecode(info);
    List <dynamic> body = json['search'];
    List <Media> allMedia = body.map((dynamic item) => Media.fromJson(item)).toList();
    return allMedia;
  }

  final _db = FirebaseFirestore.instance;

  createMedia (Media media){
    _db.collection("media").add(media.toJson());
  }
  
  
  Future <bool> doesMediaExist (String mediaName) async {
    DocumentSnapshot<Map<String, dynamic>> media = await FirebaseFirestore.instance.collection("media").doc(mediaName).get();
    if (media.exists){
      return true;
    } else {
      return false;
    }
  }


  storeMedia(String title) {
    List<Media> allMedia = makeMedia(title) as List<Media>;

    for (int i=0; i < allMedia.length; i++){
      if (/*cond para ainda não estar na db*/){
        createMedia(allMedia[i]);
      }
    }
  }

}

