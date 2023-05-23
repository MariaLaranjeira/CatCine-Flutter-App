import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Model/media.dart';
import '../main.dart';


class MediaPage extends StatefulWidget {
  final Media media;
  const MediaPage({Key? key, required this.media}) : super(key: key);

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {

  Map<int,Color> colors = {};

  double _ratingValue = 0;

  bool is1Pressed = false;
  bool is2Pressed = false;
  bool is3Pressed = false;
  bool is4Pressed = false;
  bool is5Pressed = false;

  getPosterURL() {
    if (widget.media.coverUrl != '') {
      return NetworkImage(widget.media.coverUrl);
    }
    return const AssetImage('images/catIcon.png');
  }

  getBackdropURL() {
    if (widget.media.backdropUrl != '') {
      return NetworkImage(widget.media.backdropUrl);
    }
    return const AssetImage('images/catIcon.png');
  }

  CollectionReference userDB = FirebaseFirestore.instance.collection('users');


  loadUserRating() async{
    await userDB
        .doc(FirebaseAuth.instance.currentUser!.displayName!)
        .collection('interacted_media')
        .doc(widget.media.id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        var res = data as Map<String, dynamic>;
        _ratingValue = res['rating_given'];
      }
    });
  }

  storeUserRating() async {
    var usermedia = userDB.doc(FirebaseAuth.instance.currentUser!.displayName!).collection('interacted_media').doc(widget.media.id);
    await usermedia.set({
      'rating_given': _ratingValue,
    }, SetOptions(merge: true));
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff393d5a),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: (width/2.3) * 3/2,
                  width: double.infinity,
                  child:Image(
                    image: getBackdropURL(),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: ((((width/2.3) * 3/2 - (width/2.5) * 3/2)) / 2),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: (width/2.5) * 3/2,
                    width: width/2.5,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(12.0),
                    ),
                    child: Image(
                      image: getPosterURL(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/21),
              child: Text(
                widget.media.mediaName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height:10),
            
            Text(
              "${widget.media.releaseDate} . ${widget.media.runtime}m",
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 22,
              ),
            ),

            SizedBox(height:20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/21),
              child: Text(
                widget.media.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
            ),
            SizedBox(height:20),
            Text(
              "Age Rating: ${widget.media.ageRating == 1 ? 'All Audiences' : widget.media.ageRating}",
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 18,
              ),
            ),
            RatingBar(
                initialRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: Colors.yellow),
                    half: const Icon(
                      Icons.star_half,
                      color: Colors.yellow,
                    ),
                    empty: const Icon(
                      Icons.star_outline,
                      color: Colors.yellow,
                    )),
                onRatingUpdate: (value) {
                  setState(() {
                    _ratingValue = value;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
