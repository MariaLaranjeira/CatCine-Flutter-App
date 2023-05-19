import 'package:catcine_es/Model/category.dart';
import 'package:catcine_es/Pages/categoryPage.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:catcine_es/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Model/media.dart';
import '../main.dart';
import 'createCategory.dart';
import 'exploreMedia.dart';
import 'homePage.dart';

class ExploreCategories extends StatefulWidget {
  const ExploreCategories({Key? key}) : super(key: key);

  @override
  State<ExploreCategories> createState() => _ExploreCategoriesState();
}

class _ExploreCategoriesState extends State<ExploreCategories> {

  List<Category> displayList = [];

  CollectionReference catDB = FirebaseFirestore.instance.collection('categories');

  loadCats() async {

    List<String> _userKey = [];
    final query = await catDB.get();

    for (var doc in query.docs) {
      _userKey.add(doc.id);
    }

    for (String _key in _userKey){
      catDB
          .doc(_key)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();
          var res = data as Map<String, dynamic>;

          Category cat = Category.fromJson(res);

          List<String> _mediaKey = [];
          final query2 = await catDB.doc(_key).collection('catmedia').get();
          final query2DB = catDB.doc(_key).collection('catmedia');

          for (var doc in query2.docs) {
            _mediaKey.add(doc.id);
          }

          for (String _keyer in _mediaKey){
            cat.catMedia.add(await API.loadSpecificMedia(_keyer));
            query2DB
                .doc(_keyer)
                .get()
                .then((DocumentSnapshot documentSnapshot) async {
              if (documentSnapshot.exists) {
                var data = documentSnapshot.data();
                var res = data as Map<String, dynamic>;
                cat.updown[_keyer] = [res['upvotes'], res['downvotes']];
              }
            });
          }
          allLocalCats[cat.title] = cat;
        }
      });
    }
  }

  void updateList(String title) async{

    setState(() {
      displayList = allLocalCats.values.where((element) => element.title.toLowerCase().contains(title.toLowerCase()) ||
          element.title.toUpperCase().contains(title.toUpperCase())).toList();
    });
  }

  int rowCounter() {
    if (displayList.isEmpty) {
      return 0;
    }
    else if (displayList.length%2==1) {
      return (displayList.length ~/ 2) + 1;
    }
    else {
      return displayList.length ~/ 2;
    }
  }

  String getTrimmedName(Category cat) {
    if (cat.title.length > 15) {
      return '${cat.title.substring(0, 15)}...';
    }
    return cat.title;
  }

  ImageProvider getPosterURL(Category cat,var i){

    if (isCatMediaEmpty(cat) || cat.catMedia.length < 3){
      return const AssetImage('images/catIcon.png');
    } else if (cat.catMedia[i].coverUrl != '') {
      return NetworkImage(cat.catMedia[i].coverUrl);
    }
    return const AssetImage('images/catIcon.png');
  }

  bool isCatMediaEmpty(Category cat) {
    if (cat.catMedia == []){
      return true;
    }
    return false;
  }

  Column drawSecondElement(int index) {
    if (index >= displayList.length) {
      return Column();
    }
    else {
      return Column(
          children: [
            RawMaterialButton(
              onPressed: () {
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                    return CategoryPage(category: displayList[index]);
                    },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                );
               },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  color: Color(0xFFD9D9D9),
                  width: (MediaQuery.of(context).size.width/11) * 4.30,
                  height: ((MediaQuery.of(context).size.width/11) * 4.30) * 1.3,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        height: 120,
                        width: 125,
                        child: Row(
                          children: [
                            Image(
                              image: getPosterURL(displayList[index],0),
                            ),
                            Image(
                              image: getPosterURL(displayList[index],1),
                            ),
                            Image(
                              image: getPosterURL(displayList[index],2),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        getTrimmedName(displayList[index]),
                        style: const TextStyle(
                            color: Color(0xFF393D5A),
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ]
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadCats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff393d5a),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const SizedBox(height: 65,),

            Row(
                children: const [
                  SizedBox(width: 10),
                  Text(
                    "Find Categories",
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
            const SizedBox(height: 22,),
            const Text(
              "Recommended For You",
              style: TextStyle(
                color:Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15,),
            const Text(
              "Explore your recommended categories based on the ones you've liked in the past",
              style: TextStyle(
                color:Colors.white,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: DraggableScrollableActuator(
                child: ListView.builder(
                  itemCount: rowCounter(),
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Row(
                        children: [
                          Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {
                                     Navigator.push(context, PageRouteBuilder(
                                       pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                                         return CategoryPage(category: displayList[index]);
                                       },
                                       transitionDuration: Duration.zero,
                                       reverseTransitionDuration: Duration.zero,
                                     ),
                                     );
                                   },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Container(
                                      color: Color(0xFFD9D9D9),
                                      width: (MediaQuery.of(context).size.width/11) * 4.30,
                                      height: ((MediaQuery.of(context).size.width/11) * 4.30) * 1.3,
                                      child:Text(
                                        getTrimmedName(displayList[index * 2]),
                                        style: const TextStyle(
                                            color: Color(0xFF393D5A),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                              ]
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width/15,),
                          drawSecondElement((index * 2) + 1),
                        ]
                    ),
                  ),
                ),
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
