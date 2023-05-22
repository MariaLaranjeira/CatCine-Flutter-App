import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/media.dart';
import '../main.dart';


class MediaPage extends StatefulWidget {
  final Media media;
  const MediaPage({Key? key, required this.media}) : super(key: key);

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {


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
          ],
        ),
      ),
    );
  }
}
