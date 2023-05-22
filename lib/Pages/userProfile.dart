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
import 'initial.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String username = FirebaseAuth.instance.currentUser!.displayName!;
  
  String? profilePicUrl = FirebaseAuth.instance.currentUser!.photoURL;

  String defaultProfilePic = "https://firebasestorage.googleapis.com/v0/b/catcine-thebest.appspot.com/o/defaultProfilePic.png?alt=media&token=36809212-5bda-42cb-9484-6eb2298ed0eb";

  getNCreatedCats(){
    var nCreatedCats = 0;
    for (Category cat in allLocalCats.values){
      if (cat.creator == FirebaseAuth.instance.currentUser!.displayName!){
        nCreatedCats++;
      }
    }
    return nCreatedCats;
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

            SizedBox(height: height/43.37),

            const Text(
              "Watched Movies",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            Row(/*colocar os watched movies*/),

            SizedBox(height: height/21.69),

            Container(
              height: 0.9,
              width: double.infinity,
              color: const Color(0xFF6B6D7B),
            ),

            SizedBox(height: height/43.37),

            const Text(
              "Watchlist",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            Row(/*colocar os watchlist*/),

            const Expanded(child: Column()),

            Container(
              color: const Color(0xBDDFD4FF),
              height: height/17.35,
              width: double.infinity,
              child: RawMaterialButton(

                  child: const Text(
                      "Log out",
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
