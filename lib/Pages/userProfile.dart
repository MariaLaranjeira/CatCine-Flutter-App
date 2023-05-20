import 'dart:io';
import 'package:catcine_es/Pages/createCategory.dart';
import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String username = FirebaseAuth.instance.currentUser!.displayName!;
  
  String? profilePicUrl = FirebaseAuth.instance.currentUser!.photoURL;

  String defaultProfilePic = "https://firebasestorage.googleapis.com/v0/b/catcine-thebest.appspot.com/o/defaultProfilePic.png?alt=media&token=36809212-5bda-42cb-9484-6eb2298ed0eb";

  void pickUploadProfilePic() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
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
           children: [
             const SizedBox(height: 34),
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
                     const SizedBox(height: 20),

                     const Text(
                       "Created Categories: ",
                       style: TextStyle(
                         color: Colors.grey,
                         fontSize: 16,
                       ),
                     ),

                   ],
                 ),
                 const SizedBox(width: 80),
                 Container(
                   height: 85,
                   width: 85,
                   decoration: const BoxDecoration(
                     shape: BoxShape.circle,
                   ),
                   child: Image.asset(
                     'images/defaultIcon.png',
                     fit: BoxFit.cover,
                   ),
                 ),
               ],
             ),
             GestureDetector(
               onTap: () {
                 pickUploadProfilePic();
               },
               child: Container(
                 margin: const EdgeInsets.only(top: 80, bottom: 24),
                 height: 120,
                 width: 120,
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: const Color(0xFFEEF44C),
                   image: DecorationImage(image: NetworkImage(
                     profilePicUrl != null ? profilePicUrl! : defaultProfilePic,
                    ),
                     fit: BoxFit.fill,
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
