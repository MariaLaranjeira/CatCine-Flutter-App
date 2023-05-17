import 'package:catcine_es/Model/category.dart';
import 'package:catcine_es/Pages/createCategory.dart';
import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/homePage.dart';
import 'package:catcine_es/Pages/searchMediaForCat.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:catcine_es/my_flutter_app_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/media.dart';


class CategoryPage extends StatefulWidget{

  final Category category;
  const CategoryPage({super.key, required this.category});

  late List<List<int,int>> updown;

  @override
  State<CategoryPage> createState() => _CategoryPageState();

}

class _CategoryPageState extends State<CategoryPage>{

  late Category cat;
  bool isLiked = false;

  CollectionReference catDB = FirebaseFirestore.instance.collection(
      'categories');

  updateLikes() async {
    var likes;

    catDB
        .doc(cat.title)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        var res = data as Map<String, dynamic>;

        likes = res['likes'];
      }
    });

    if (isLiked){
      likes--;
    } else {
      likes++;
    }
    var ref = catDB.doc(cat.title);
    await ref.update({
      'likes':likes,
    });
  }

  Future<bool> doesMediaExist(String id) async {
    var ref = await catDB.doc(id).get();
    return ref.exists;
  }
  updateList() async {
    var ref = catDB.doc(cat.title);
    for (Media media in cat.catMedia) {
      if (!await doesMediaExist(media.id)){
        var list = ref.collection('catmedia').doc(media.id);
        list.set({
          'upvotes': 0,
          'downvotes': 0
        }, SetOptions(merge: true));
      }
    }
  }

  ImageProvider getPosterURL(Media media) {
    if (media.coverUrl != '') {
      return NetworkImage(media.coverUrl);
    }
    return const AssetImage('images/catIcon.png');
  }

  String getTrimmedName(Media media) {
    if (media.mediaName.length > 25) {
      return '${media.mediaName.substring(0, 25)}...';
    }
    return media.mediaName;
  }

  getIcon(){
    if (isLiked) {
      return const Icon(MyFlutterApp.heart);
    }
    return const Icon(MyFlutterApp.heart_outline);
  }

  @override
  void initState(){
    super.initState();
    cat = widget.category;

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


      body: Stack(
        children: [
          Container (
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topLeft,
                image: AssetImage('images/catBackdrop.png'),
                fit: BoxFit.contain,
              )
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35.0,
                ),

                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/6.5,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 147,
                          height: 39,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xB3D9D9D9),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {  },
                                icon: const Icon(Icons.edit),
                                color: const Color(0xFF393D5A),
                              ),
                              Container(
                                color: const Color(0xCCA7A7A7),
                                height: 50,
                                width: 0.5,
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  updateList();
                                  Navigator.push(context, PageRouteBuilder(
                                  pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                                    return const SearchCreateCat();
                                  },
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                  ),
                                  ).whenComplete(() =>
                                      setState(() {})
                                  );
                                },
                                color: const Color(0xFF393D5A),
                              ),
                              Container(
                                color: const Color(0xCCA7A7A7),
                                height: 50,
                                width: 0.5,
                              ),
                              IconButton(
                                icon: getIcon(),
                                onPressed: () {
                                  setState(() {
                                    updateLikes();
                                    if (isLiked){
                                      cat.likes--;
                                    } else {
                                      cat.likes++;
                                    }
                                    isLiked = !isLiked;
                                  });
                                },
                                color: const Color(0xFF393D5A),
                              ),
                            ]
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat.title,
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Text(
                            "by @SironaRyan",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 20,
                      child: Image(
                        image: AssetImage('images/heart.png'),
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${cat.likes}",
                      style: const TextStyle(
                        color: Colors.white,
                      )
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    const SizedBox(
                      height: 20,
                      child: Image(
                        image: AssetImage('images/votes.png'),
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "${cat.interactions}",
                        style: const TextStyle(
                          color: Colors.white,
                        )
                    ),
                  ],
                ),
                const SizedBox(
                  height: 13,
                ),
                Text(
                  cat.description,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox( height:9.0),
                Container(
                  height: 0.9,
                  width: double.infinity,
                  color: const Color(0xFF6B6D7B),
                ),
                Expanded(
                  child: DraggableScrollableActuator(
                    child: ListView.builder(
                      itemCount: cat.catMedia.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Column(
                          children: [
                            Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 55,
                                        child: IconButton(
                                          iconSize: 40,
                                          icon: const Icon(MyFlutterApp.upvote),
                                          color : const Color(0xFFD9D9D9),
                                          onPressed: () {

                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 20,
                                          child: Text(
                                            "0",
                                            style: TextStyle(
                                              color: Colors.white,
                                            )
                                          )
                                      ),
                                      SizedBox(
                                        height: 55,
                                        child: IconButton(
                                          iconSize: 40,
                                          icon:  const Icon(MyFlutterApp.downvote),
                                          color : const Color(0xFFD9D9D9),
                                          onPressed: () {

                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width/5,
                                      height: (MediaQuery.of(context).size.width/5) * 3/2,
                                      child: Image(
                                        fit: BoxFit.fill,
                                        isAntiAlias: true,
                                        image: getPosterURL(cat.catMedia[index]),
                                        semanticLabel: "${cat.catMedia[index].mediaName}...",
                                        loadingBuilder: (context, child, progress) {
                                          return progress == null ? child : const LinearProgressIndicator();
                                        },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: RichText(
                                    text : TextSpan (
                                        children: <TextSpan> [
                                          TextSpan(text:"${getTrimmedName(cat.catMedia[index])}\n",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                                          TextSpan(text:cat.catMedia[index].description, style: const TextStyle(color: Colors.white, fontSize: 16)),
                                        ]
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 0.9,
                              width: double.infinity,
                              color: const Color(0xFF6B6D7B),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}