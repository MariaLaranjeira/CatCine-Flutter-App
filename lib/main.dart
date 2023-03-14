import 'package:flutter/material.dart';

import 'api.dart';
import 'media.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:ExploreFilm()
    );
  }
}

class ExploreFilm extends StatefulWidget{
  const ExploreFilm({Key? key}) : super(key: key);

  @override
  State<ExploreFilm> createState() => _ExploreFilmState();
}

class _ExploreFilmState extends State<ExploreFilm>{
  Api client = Api();

  List<Media> mediaList = [];
  List<Media> displayList=[];

  void updateList(String title) async{
    mediaList = await client.makeMedia(title);
    displayList=List.from(mediaList);

    setState(() {
      displayList = mediaList.where((element) => element.mediaName!.toLowerCase().contains(title.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff393d5a),
        appBar: AppBar(
          backgroundColor: Color(0xff393d5a), // not sure o que é isto
          elevation: 0.0,
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                      "Explore",
                      style: TextStyle(
                          color:Colors.white, fontSize: 30.0
                      ),
                  ),
                  SizedBox(
                    height:20.0,
                  ),
                  TextField(
                    onChanged: (title) => updateList(title),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffcccede),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search ...",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(

                      child: ListView.builder(
                          itemCount: displayList.length,
                          itemBuilder: (context, index) => ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            title: Text(
                                displayList[index].mediaName!,
                                style: TextStyle(
                                    color: Colors.white,
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
