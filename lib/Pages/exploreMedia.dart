import 'package:catcine_es/Pages/homePage.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import '../Model/media.dart';
import 'createCategory.dart';
import 'exploreCategories.dart';
import 'initial.dart';

class ExploreMedia extends StatefulWidget{
  const ExploreMedia({Key? key}) : super(key: key);

  @override
  State<ExploreMedia> createState() => _ExploreMediaState();
}

class _ExploreMediaState extends State<ExploreMedia>{

  List<Media> mediaList = [];
  List<Media> displayList = [];

  Future<void> initList() async {
    await API.loadMedia();
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  void updateList(String title) async{
    if (title.isEmpty) {
      setState(() {
        displayList = [];
      });
      return;
    }
    mediaList = await Media.searchTitle(title);
    await API.storeMedia();
    API.updateRemoteList(mediaList);


    displayList = mediaList;


    setState(() {
      displayList = mediaList.where((element) => element.mediaName.toLowerCase().contains(title.toLowerCase())).toList();
    });
  }

  ImageProvider getPosterURL(Media media) {
    if (media.coverUrl != '') {
      return NetworkImage(media.coverUrl);
    }
    return const AssetImage('images/catIcon.png');
  }

  String getTrimmedName(Media media) {
    if (media.mediaName.length > 15) {
      return '${media.mediaName.substring(0, 15)}...';
    }
    return media.mediaName;
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
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                        return const Home();
                      },
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                        return const Profile();
                      },
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
                SizedBox(
                  height: 60,
                  child: IconButton(
                    iconSize: 60,
                    icon: Image.asset('images/catIcon.png'),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                        pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                          return const CreateCategoryScreen();
                        },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                            (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ),
                IconButton(
                 icon: const Icon(Icons.search),
                 onPressed: () {},
                ),
                IconButton(
                 icon: const Icon(Icons.category),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                        return const ExploreCategories();
                      },
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                          (Route<dynamic> route) => false,
                    );
                  },
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

            Row(
              children: const [
                SizedBox(width: 18,),
                Text(
                  "Explore",
                  style: TextStyle(
                    color:Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]
            ),

            const SizedBox(
              height:20.0,
            ),
            Row(
              children: const [
                SizedBox(width: 18),
                Text(
                  "Let's find your favourite movies, TV shows\nand more ...",
                  style: TextStyle(
                    color: Color.fromARGB(215, 255, 255, 255),
                    fontSize: 16.5,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ]
            ),
            const SizedBox(
              height:30.0,
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
            const SizedBox(height: 10,),
            Expanded(
              child: DraggableScrollableActuator(
                child: ListView.builder(
                  itemCount: displayList.length ~/ 2,
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Row(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: SizedBox(
                                width: (MediaQuery.of(context).size.width/11) * 4.35,
                                height: 250,
                                child: Image(
                                  fit: BoxFit.fill,
                                  isAntiAlias: true,
                                  image: getPosterURL(displayList[index * 2]),
                                  semanticLabel: "${displayList[index * 2].mediaName}...",
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null ? child : const LinearProgressIndicator();
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              getTrimmedName(displayList[index * 2]),
                              style: const TextStyle(
                                color: Colors.white
                              ),
                            )
                          ]
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/11,),
                        Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: SizedBox(
                                  width: (MediaQuery.of(context).size.width/11) * 4.35,
                                  height: 250,
                                  child: Image(
                                    isAntiAlias: true,
                                    image: getPosterURL(displayList[index * 2 + 1]),
                                    fit: BoxFit.fill,
                                    semanticLabel: "${displayList[index * 2 + 1].mediaName}...",
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null ? child : const LinearProgressIndicator();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                getTrimmedName(displayList[index * 2 + 1]),
                                style: const TextStyle(
                                    color: Colors.white
                                ),
                              )
                            ]
                        ),
                      ]

                    ),
                  ),
                ),
              ),
            ),

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
          ],
        ),
      ),
    );
  }
}