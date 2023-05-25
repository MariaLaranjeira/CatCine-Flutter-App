import 'dart:io';
import 'package:catcine_es/Pages/createCategory.dart';
import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/homePage.dart';
import 'package:catcine_es/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/category.dart';

import '../Model/media.dart';
import 'initial.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  List<Media> profileLists=[];
  List<Category> myCats = [];

  String username = FirebaseAuth.instance.currentUser!.displayName!;
  
  String? profilePicUrl = FirebaseAuth.instance.currentUser!.photoURL;

  String defaultProfilePic = "https://firebasestorage.googleapis.com/v0/b/catcine-thebest.appspot.com/o/defaultProfilePic.png?alt=media&token=36809212-5bda-42cb-9484-6eb2298ed0eb";

  isCatMediaEmpty(Category cat) {
    if (cat.catMedia == []){
      return true;
    }
    return false;
  }

  getPosterURL(Category cat,var i){

    if (isCatMediaEmpty(cat) || cat.catMedia.length < 3){
      return const AssetImage('images/catIcon.png');
    } else if (cat.catMedia[i].coverUrl != '') {
      return NetworkImage(cat.catMedia[i].coverUrl);
    }
    return const AssetImage('images/catIcon.png');
  }


  getTrimmedName(Category cat) {
    if (cat.title.length > 25) {
      return '${cat.title.substring(0, 25)}...';
    }
    return cat.title;
  }
  getMyCats(){
    for (var cat in allLocalCats.values){
      if (cat.creator == FirebaseAuth.instance.currentUser!.displayName!){
        myCats.add(cat);
      }
    }
  }

  getNCreatedCats(){
    var nCreatedCats = 0;
    for (Category cat in allLocalCats.values){
      if (cat.creator == FirebaseAuth.instance.currentUser!.displayName!){
        nCreatedCats++;
      }
    }
    return nCreatedCats;
  }

  boxDecorator(var i) {
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

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );

    Reference ref = FirebaseStorage.instance
        .ref().child("$username.jpg");

    if (image != null) {
      await ref.putFile(File(image.path));

      await ref.getDownloadURL().then((value) async {
        setState(() {
          profilePicUrl = value;
        });
        FirebaseAuth.instance.currentUser!.updatePhotoURL(profilePicUrl);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMyCats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff393d5a),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height/25.51),

            Row(
              children: [
                Column(
                  children: [
                    Text(
                      username,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),

                    SizedBox(height: height/43.37),

                    Text(
                      "Created Categories: ${getNCreatedCats()}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),

                  ],
                ),

                SizedBox(width: width/5.14),

                GestureDetector(
                  onTap: () {
                    pickUploadProfilePic();
                  },
                  child: Container(
                    height: width/4.84,
                    width: width/4.84,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(
                        profilePicUrl != null ? profilePicUrl! : defaultProfilePic,
                      ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: height/43.37),

            Container(
              height: 0.9,
              width: double.infinity,
              color: const Color(0xFF6B6D7B),
            ),
            const SizedBox(height: 20),

            Container(
              color: const Color(0xBDDFD4FF),
              height: height/17.35,
              width: double.infinity,
              child: RawMaterialButton(

                  child: const Text(
                      "Log out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      )
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
                onPressed: () {},
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
