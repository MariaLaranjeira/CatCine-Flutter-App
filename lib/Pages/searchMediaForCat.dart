import 'package:catcine_es/Pages/createCategory.dart';
import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:flutter/material.dart';

import '../Model/media.dart';
import '../Model/searchesBackEnd.dart';

class SearchCreateCat extends StatefulWidget {
  const SearchCreateCat({Key? key}) : super(key: key);

  @override
  State<SearchCreateCat> createState() => _SearchCreateCatState();
}

class _SearchCreateCatState extends State<SearchCreateCat> {

  List<Media> mediaList = [];
  List<Media> displayList = [];

  void updateList(String title) async{

    mediaList = await SearchesBackEnd.updateList(title);
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
    if (media.mediaName.length > 25) {
      return '${media.mediaName.substring(0, 25)}...';
    }
    return media.mediaName;
  }

  Color getColor(Media media) {
    if (mediaCat.contains(media)) {
      return const Color(0xFF42A7AD);
    }
    else {
      return Color(0xFF6E7398);
    }
  }

  ListView listViewProvider() {
    if (displayList.isNotEmpty) {
      return ListView.builder(
        itemCount: displayList.length,
        itemBuilder: (context, index) => ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          title: Container(
            decoration: BoxDecoration(
              color: getColor(displayList[index]),
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: RawMaterialButton(
              onPressed: () {
                if (mediaCat.contains(displayList[index])) {
                  setState(() {
                    mediaCat.remove(displayList[index]);
                  });
                }
                else {
                  setState(() {
                    mediaCat.add(displayList[index]);
                  });
                }
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      height: (MediaQuery.of(context).size.width/5) * 3/2,
                      child: Image(
                        fit: BoxFit.fill,
                        isAntiAlias: true,
                        image: getPosterURL(displayList[index]),
                        semanticLabel: "${displayList[index].mediaName}...",
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
                            TextSpan(text:"${getTrimmedName(displayList[index])}\n",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                            TextSpan(text:displayList[index].description, style: const TextStyle(color: Colors.white, fontSize: 16)),
                          ]
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else {
      return ListView.builder(
        itemCount: mediaCat.length,
        itemBuilder: (context, index) => ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          title: Container(
            decoration: const BoxDecoration(
                color: Color(0xFF42A7AD),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            child: RawMaterialButton(
              onPressed: () {
                setState(() {
                  mediaCat.remove(mediaCat[index]);
                });
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/5,
                      height: (MediaQuery.of(context).size.width/5) * 3/2,
                      child: Image(
                        fit: BoxFit.fill,
                        isAntiAlias: true,
                        image: getPosterURL(mediaCat[index]),
                        semanticLabel: "${mediaCat[index].mediaName}...",
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
                            TextSpan(text:"${getTrimmedName(mediaCat[index])}\n",style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                            TextSpan(text:mediaCat[index].description, style: const TextStyle(color: Colors.white, fontSize: 16)),
                          ]
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 73,
        flexibleSpace: Column(
          children: [
            const SizedBox(height: 45),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width/8.5),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.17,
                  child: TextField(
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
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color(0xff717488),
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xff393d5a),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Expanded(
              child: DraggableScrollableActuator(
                child: listViewProvider()
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