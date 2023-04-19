import 'package:catcine_es/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../media.dart';
import 'initial.dart';

class ExploreFilm extends StatefulWidget{
  const ExploreFilm({Key? key}) : super(key: key);

  @override
  State<ExploreFilm> createState() => _ExploreFilmState();
}

class _ExploreFilmState extends State<ExploreFilm>{

  List<Media> mediaList = [];
  List<Media> displayList = [];

  Future<void> initList() async{
    allLocalMedia = await API.loadMedia();
  }

  @override
  void initState() {
    initList();
    super.initState();
  }

  void updateList(String title) async{
    if (title.isEmpty) {
      setState(() {
        displayList = [];
      });
      return;
    }
    mediaList = await Media.searchTitle(title);
    await API.storeMedia(title);
    API.updateRemoteList();
    displayList = mediaList;


    setState(() {
      displayList = mediaList.where((element) => element.mediaName!.toLowerCase().contains(title.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff393d5a),

      bottomNavigationBar: BottomAppBar(
        color: const Color(0xCACBCBD2),
        child: IconTheme(
          data: const IconThemeData(color: Color(0xCB6D706B)),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {},
                ),
                IconButton(
                 icon: Image.asset('images/catIcon.png'),
                  onPressed: () {},
                ),
                IconButton(
                 icon: const Icon(Icons.search),
                 onPressed: () {},
                ),
                IconButton(
                 icon: const Icon(Icons.category),
                 onPressed: () {},
                ),
              ],
            ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(height: 50,),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: RawMaterialButton(
                child: const Text(
                  "Log out temporary",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0)
                ),
                  onPressed: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const InitialScreen())
                    );
                  }),
            ),
            const Text(
              "Explore",
              style: TextStyle(
                color:Colors.white,
                fontSize: 30.0,
              ),
            ),
            const SizedBox(
              height:20.0,
            ),
            TextField(
              onChanged: (title) => updateList(title),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffcccede),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search ...",
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            Expanded(
              child: DraggableScrollableActuator(
                child: ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Text(
                      displayList[index].mediaName!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}