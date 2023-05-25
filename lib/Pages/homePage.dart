import 'package:catcine_es/Pages/categoryPage.dart';
import 'package:catcine_es/Pages/createCategory.dart';
import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:catcine_es/main.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../Model/category.dart';
import '../api.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  getRandomCat() {
    for (var cat in allLocalCats.values){
      print(cat.title);
    }
    List<Category> allCats = allLocalCats.values.toList();
    final random = Random();
    Category element = allCats[random.nextInt(allCats.length)];
    return element;
  }


  initList() async {
    if (!loadedFromFirebase) {
      await API.loadMedia();
      await API.loadCats();
    }
  }

  @override
  void initState() {
    super.initState();
    initList();
    loadedFromFirebase = true;
  }
  
  @override
  Widget build(BuildContext context) {

    print(MediaQuery.of(context).size.width);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff393d5a),

      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/26.6,),
                  const Text(
                    "Welcome to Catcine!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/26.6,),
                  RichText(
                    text: const TextSpan(
                      children: <TextSpan> [
                        TextSpan(text: "Use the ", style: TextStyle(color: Colors.white70,fontSize: 22.0)),
                        TextSpan(text: "bottom bar ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 22.0)),
                        TextSpan(text: "to navigate through our app. Tap the ", style: TextStyle(color: Colors.white70,fontSize: 22.0)),
                        TextSpan(text: "Cat Icon ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 22.0)),
                        TextSpan(text: "to create your category and search for other people's categories in the ", style: TextStyle(color: Colors.white70,fontSize: 22.0)),
                        TextSpan(text: " Find Categories Menu. ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 22.0)),
                        TextSpan(text: "Downvote ", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEC6B76),fontSize: 22.0)),
                        TextSpan(text: "and ", style: TextStyle(color: Colors.white70,fontSize: 22.0)),
                        TextSpan(text: "Upvote ", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF42A7AD),fontSize: 22.0)),
                        TextSpan(text: "media inside categories and tap on each for more info and to give it your rating out of 5 stars. Get creative and create the most unique categories for others to see!", style: TextStyle(color: Colors.white70,fontSize: 22.0)),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/11.4,
            width: MediaQuery.of(context).size.width/2.74,
            child: RawMaterialButton(
              fillColor: const Color(0xFFEC6B76),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 0.0,
              onPressed: () {
                Category randCat = getRandomCat();
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                    return CategoryPage(category:randCat);
                  },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                );
              },
              child: const Text(
                "Take me to a\n random category!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height/4.7,
            child:Image.asset('images/kitty.png'),
          ),
        ],
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
