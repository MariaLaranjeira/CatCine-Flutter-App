import 'package:catcine_es/Pages/categoryPage.dart';
import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/homePage.dart';
import 'package:catcine_es/Pages/searchMediaForCat.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Model/category.dart';
import '../Model/media.dart';


List<Media> mediaCat = [];


class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategoryScreen> {

  var maxLength = 200;
  var textLength = 0;
  late Category newCat;

  ImageProvider image0 = MemoryImage(kTransparentImage);
  ImageProvider image1 = MemoryImage(kTransparentImage);
  ImageProvider image2 = MemoryImage(kTransparentImage);

  TextEditingController nameCat = TextEditingController();
  TextEditingController descCat = TextEditingController();

  ImageProvider getPosterURL(var i) {
    if (mediaCat.isEmpty){
      return const AssetImage('images/transparent.png');
    }
    if (mediaCat[i].coverUrl != '' && i < mediaCat.length) {
      NetworkImage imageMedia = NetworkImage(mediaCat[i].coverUrl);
      setState(() {
        imageMedia;
      });
      return NetworkImage(mediaCat[i].coverUrl);
    }
    else if (mediaCat[i].coverUrl == '') {
      return const AssetImage('images/catIcon.png');
    }
    else {
      return const AssetImage('images/transparent.png');
    }
  }
  
  BoxDecoration boxDecorator(var i) {
    if (mediaCat.isEmpty){
      return const BoxDecoration();
    }
    if (i < mediaCat.length) {
      return BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]
      );
    }
    else {
      return const BoxDecoration();
    }
  }

  DecoratedBox displayDecoratedBox() {
    if (mediaCat.length > 3) {
      return DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.black26,
        ),
        child: Center(
          child: Text (
              "+${mediaCat.length-3}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold
              )
          ),
        ),
      );
    }
    return const DecoratedBox(decoration: BoxDecoration());
  }
  
  static CollectionReference catDB = FirebaseFirestore.instance.collection(
      'categories');

  static addCat(Category cat) async {

    var ref = catDB.doc(cat.title);

    ref.set({
      'title': cat.title,
      'creator': cat.creator,
      'description': cat.description,
      'catMedia': cat.catMedia,
      'likes': cat.likes,
      'interactions': cat.interactions,
    },
      SetOptions(merge: true),
    );
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
                  onPressed: () {},
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
          SingleChildScrollView(
            //physics: const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
            child: Padding (
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                          children: <TextSpan> [
                            TextSpan(text: "Create Your\n", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 32.0)),
                            TextSpan(text: "Cat", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEC6B76),fontSize: 32.0)),
                            TextSpan(text: "egory", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32.0))
                          ],
                          ),
                        ),
                      ]
                    ),
                    const SizedBox( height:20.0),

                    const Text(
                      "Add movies, upvote and downvote them, \nand share it with your friends!",
                       style: TextStyle(
                         color: Color.fromARGB(215, 255, 255, 255),
                         fontSize: 16.5,
                         fontWeight: FontWeight.normal
                        ),
                    ),
                    const SizedBox( height:9.0),
                    Container(
                      height: 0.9,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    const SizedBox( height: 9.0),
                    const Text(
                      "Name your category:",
                      style: TextStyle(
                          color: Color.fromARGB(215, 255, 255, 255),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  const SizedBox( height:20.0),

                  TextField(
                    key: const Key("categoryName"),
                    controller: nameCat,
                    decoration: InputDecoration(
                      filled:true,
                      fillColor: const Color(0xFFFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: " Enter your category’s name",
                    ),
                  ),
                    const SizedBox( height:10.0),
                    const Text (
                      "Write a Description:",
                      style: TextStyle(
                          color: Color.fromARGB(215, 255, 255, 255),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  const SizedBox( height:20.0),

                  TextFormField(
                    key: const Key("categoryDescription"),
                    controller: descCat,
                    decoration: InputDecoration(
                      filled:true,
                      fillColor: const Color(0xFFFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: " Enter your description ...",
                      suffixText: '${textLength.toString()}/${maxLength.toString()}',
                      counterText: "",
                    ),
                    cursorRadius: const Radius.circular(10),
                    keyboardType: TextInputType.text,
                    maxLength: maxLength,
                    onChanged: (value) {
                      setState(() {
                        textLength = value.length;
                      });
                    },
                    maxLines: 4,
                  ),
                  const SizedBox( height: 20.0),
                  const Text(
                    "Add films:",
                    style: TextStyle(
                        color: Color.fromARGB(215, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox( height: 20.0),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFCFDBDC),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 32,
                    height: (MediaQuery.of(context).size.width - 32)/3.1,
                    child: Row(
                        children: [
                        SizedBox(width: MediaQuery.of(context).size.width/20.57),
                        SizedBox.square(
                          dimension: MediaQuery.of(context).size.width/4.56,
                          child: RawMaterialButton(
                            fillColor: const Color(0x8B84898B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              Navigator.push(context, PageRouteBuilder(
                                pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                                  return const SearchCreateCat();
                                },
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              ).whenComplete(() {
                                setState(() {
                                  image0 = getPosterURL(0);
                                  image1 = getPosterURL(1);
                                  image2 = getPosterURL(2);
                                });
                              });
                            },
                            child: const Text(
                              "+",
                              style: TextStyle(
                                  color: Color(0xFFCFDBDC),
                                  fontSize: 54.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width/27.42),
                        SizedBox(
                          height: (MediaQuery.of(context).size.width/5.87) * 3/2,
                          width: MediaQuery.of(context).size.width/1.62,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                left: 0,
                                child: Container(
                                  decoration: boxDecorator(0),
                                  child: Image(image: image0,
                                    height: (MediaQuery.of(context).size.width/5.87) * 3/2,
                                    width: MediaQuery.of(context).size.width/5.87,
                                    colorBlendMode: BlendMode.screen,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width/5.87/5*4,
                                child: Container(
                                  decoration: boxDecorator(1),
                                  child: Image(image: image1,
                                    height: (MediaQuery.of(context).size.width/5.87) * 3/2,
                                    width: MediaQuery.of(context).size.width/5.87,
                                    colorBlendMode: BlendMode.screen,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width/5.87/5*8,
                                child: Container(
                                  decoration: boxDecorator(2),
                                  child: Image(image: image2,
                                    height: (MediaQuery.of(context).size.width/5.87) * 3/2,
                                    width: MediaQuery.of(context).size.width/5.87,
                                    colorBlendMode: BlendMode.screen,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width/5.87/5*12,
                                height: (MediaQuery.of(context).size.width/5.87) * 3/2,
                                width: MediaQuery.of(context).size.width/5.87,
                                child: displayDecoratedBox()
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height:30),
                  Center(
                    child:SizedBox(
                      key: const Key("CreateButton"),
                      width:200,
                      child: RawMaterialButton(
                        fillColor: const Color(0xFFEC6B76),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        onPressed: () {
                          newCat = Category(mediaCat,"", descCat.text, nameCat.text, 0, 0);
                          addCat(newCat);
                          Navigator.push(context, PageRouteBuilder(
                            pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                              return CategoryPage(category: newCat);
                            },
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                          );
                        },
                        child: const Text(
                          "Create" ,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              ),
            ),
          ],
      ),
    );
  }
}



