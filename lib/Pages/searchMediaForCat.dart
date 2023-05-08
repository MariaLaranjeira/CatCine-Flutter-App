import 'package:catcine_es/Pages/createCategory.dart';
import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:flutter/material.dart';

import '../Model/media.dart';
import '../Model/searchesBackEnd.dart';

class searchCreateCat extends StatefulWidget {
  const searchCreateCat({Key? key}) : super(key: key);

  @override
  State<searchCreateCat> createState() => _searchCreateCatState();
}

class _searchCreateCatState extends State<searchCreateCat> {

  List<Media> mediaList = [];
  List<Media> displayList = [];

  void updateList(String title) async{

    mediaList = await SearchesBackEnd.updateList(title);
    setState(() {
      displayList = mediaList.where((element) => element.mediaName.toLowerCase().contains(title.toLowerCase())).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
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
              hintText: "Film, TV Show ...",
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ],
        ),
      ),




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
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                    pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                      return const ExploreMedia();
                    },
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                        (Route<dynamic> route) => false,
                  );
                },
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
    );
  }
}