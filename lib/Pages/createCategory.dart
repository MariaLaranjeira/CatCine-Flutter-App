import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/homePage.dart';
import 'package:catcine_es/Pages/searchMediaForCat.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:flutter/material.dart';

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

  TextEditingController nameCat = TextEditingController();
  TextEditingController descCat = TextEditingController();

  ImageProvider getPosterURL(var i) {
    if (mediaCat.isEmpty){
      return const AssetImage('images/catIcon.png');
    }
    if (mediaCat[i].coverUrl != '') {
      NetworkImage imageMedia = NetworkImage(mediaCat[i].coverUrl);
      setState(() {
        imageMedia;
      });
      return NetworkImage(mediaCat[i].coverUrl);
    }
    return const AssetImage('images/catIcon.png');
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
                    cursorRadius: Radius.circular(10),
                    keyboardType: TextInputType.text,
                    autofocus: true,
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
                  Row(
                      children: [
                      const SizedBox( height: 26.0),
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: RawMaterialButton(
                          fillColor: Color(0x8B84898B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            Navigator.push(context, PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                                return const searchCreateCat();
                              },
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                            );
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
                      const SizedBox(width:15),
                      Row(
                        children: <Widget> [
                          SizedBox(
                            height: 95,
                            child: Image(
                              image: getPosterURL(0),
                            ),
                          ),
                          SizedBox(
                            height: 95,
                            child: Image(
                              image: getPosterURL(1),
                            ),
                          ),
                          SizedBox(
                            height: 95,
                            child: Image(
                              image: getPosterURL(2),
                            ),
                          ),
                          SizedBox(
                            height: 95,
                            width: 60,
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: Colors.black26
                              ),
                              child: Text (
                                  "+${mediaCat.length-3}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                          newCat = Category(mediaCat,"", descCat as String, nameCat as String, 0, 0);
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



