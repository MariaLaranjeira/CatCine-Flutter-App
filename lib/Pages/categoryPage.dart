import 'package:catcine_es/Model/category.dart';
import 'package:catcine_es/Pages/createCategory.dart';
import 'package:catcine_es/Pages/exploreCategories.dart';
import 'package:catcine_es/Pages/exploreMedia.dart';
import 'package:catcine_es/Pages/homePage.dart';
import 'package:catcine_es/Pages/searchMediaForCat.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:catcine_es/my_flutter_app_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/media.dart';


class CategoryPage extends StatefulWidget{

  final Category category;

  const CategoryPage({super.key, required this.category});


  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>{

  late Category cat;
  late final bool initialLike;
  late final int initialInteractions;
  late final Map<String, bool> initialVotesUser;

  var maxLength = 200;
  var textLength = 0;
  TextEditingController descCat = TextEditingController();

  String creatorUsername = '';
  String username = FirebaseAuth.instance.currentUser!.displayName!;
  bool isLiked = false;
  bool isEditMode = false;
  Map<String, bool> votedMedia = {};

  CollectionReference catDB = FirebaseFirestore.instance.collection('categories');
  CollectionReference userDB = FirebaseFirestore.instance.collection('users');


  getButtons(){
    if (username == cat.creator){
      return Container(
        width: 147,
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color(0xB3D9D9D9),
        ),
        child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isEditMode = true;
                  });
                },
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
                  updateCatListOnAddedMedia();
                  Navigator.push(
                    context, PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation1,
                        Animation<double> animation2) {
                      return SearchCreateCat(cat: cat,);
                    },
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration
                        .zero,
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
                    if (isLiked) {
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
      );
    }
    else {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 4.12,
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color(0xB3D9D9D9),
        ),
        child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  updateCatListOnAddedMedia();
                  Navigator.push(
                    context, PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation1,
                        Animation<double> animation2) {
                      return SearchCreateCat(cat: cat,);
                    },
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration
                        .zero,
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
                    if (isLiked) {
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
      );
    }
  }

  Future<bool> doesUserCatExist(String title) async {
    var ref = await catDB.doc(FirebaseAuth.instance.currentUser!.displayName).collection('interacted_cats').doc(title).get();
    return ref.exists;
  }

  loadCreatorName() async {
    var temp = '';
    await catDB
        .doc(cat.title)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        var res = data as Map<String, dynamic>;
        temp = res['creator'];
      }
    });
    setState(() {
      creatorUsername = temp;
    });
  }
  
  loadUpDownMediaMap() {
    if (cat.updown.isEmpty) {
      
    }
  }

  getAllCatInfo() async {
    await catDB
        .doc(cat.title)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        var res = data as Map<String, dynamic>;

        cat.likes = res['likes'];
        cat.interactions = res['interactions'];
      }
    });

    var catmedia = await catDB.doc(cat.title).collection('catmedia').get();
    var catmediaDB = catDB.doc(cat.title).collection('catmedia');

    List<String> _mediaId = [];
    for (var doc in catmedia.docs) {
      _mediaId.add(doc.id);
    }

    for (String _key in _mediaId){
      await catmediaDB
          .doc(_key)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();
          var res = data as Map<String, dynamic>;

          cat.updown[_key]![0] = res['upvotes'];
          cat.updown[_key]![1] = res['downvotes'];

        }
      });
    }

    if (await doesUserCatExist(cat.title)){
      var usercatsDB = userDB.doc(username).collection('interacted_cats');

      var catInfoUser = usercatsDB.doc(cat.title);
      await catInfoUser.get().then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();
          var res = data as Map<String, dynamic>;

          initialLike = res['liked'];
        }
      });

      var usercatsmediaDB = catInfoUser.collection('interacted_media');
      var usercatsmedia = await catInfoUser.collection('interacted_media').get();

      List<String> _usercatmediaId = [];
      for (var doc in usercatsmedia.docs) {
        _usercatmediaId.add(doc.id);
      }

      for (String _key in _usercatmediaId) {
        var mediaInfoCat = usercatsmediaDB.doc(_key);
        await mediaInfoCat.get().then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            var data = documentSnapshot.data();
            var res = data as Map<String, dynamic>;

            votedMedia[_key] = res['voted'];

          }
        });
      }
      initialInteractions = votedMedia.length;
    } else {
      initialInteractions = 0;
      initialLike = false;
      initialVotesUser = votedMedia;
    }
  }

  updateAllCatInfo() async {
    var likes = 0;
    var interactions = 0;

    await catDB
        .doc(cat.title)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data();
        var res = data as Map<String, dynamic>;

        likes = res['likes'];
        interactions = res['interactions'];
      }
    });

    if (isLiked != initialLike && isLiked){
      likes++;
    } else if (isLiked != initialLike && !isLiked){
      likes--;
    }

    interactions += votedMedia.length - initialInteractions;

    var ref = catDB.doc(cat.title);
    await ref.update({
      'likes':likes,
      'interactions':interactions,
    });

    var catmedia = await catDB.doc(cat.title).collection('catmedia').get();
    var catmediaDB = catDB.doc(cat.title).collection('catmedia');

    List<String> _mediaId = [];
    for (var doc in catmedia.docs) {
      _mediaId.add(doc.id);
    }

    for (String _key in _mediaId){
      var tempUp;
      var tempDown;

      await catmediaDB
          .doc(_key)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data();
          var res = data as Map<String, dynamic>;

          tempUp = res['upvotes'];
          tempDown = res['downvotes'];

        }
      });

      if (initialVotesUser.containsKey(_key) && !votedMedia.containsKey(_key)) {
        if (initialVotesUser[_key]!) {
          tempUp--;
        } else {
          tempDown--;
        }
      } else if (!initialVotesUser.containsKey(_key) && votedMedia.containsKey(_key)) {
        if (votedMedia[_key]!) {
          tempUp++;
        } else {
          tempDown++;
        }
      } else if (initialVotesUser.containsKey(_key) && votedMedia.containsKey(_key)) {
        if (votedMedia[_key]! != initialVotesUser[_key]! && votedMedia[_key]!) {
          tempUp++;
          tempDown--;
        } else if (votedMedia[_key]! != initialVotesUser[_key]! && !votedMedia[_key]!) {
          tempUp--;
          tempDown++;
        }
      }

      var reffer = ref.collection('catmedia').doc(_key);
      await reffer.update({
        'upvotes': tempUp,
        'downvotes': tempDown,
      });

    }

    if (await doesUserCatExist(cat.title)){
      await userDB.doc(username).collection('interacted_cats').doc(cat.title).delete();

      var usercat = userDB.doc(username).collection('interacted_cats').doc(cat.title);

      await usercat.set({
        'isLiked': isLiked,
      });

      for(var elem in votedMedia.keys) {
        usercat.set({
          elem : votedMedia[elem],
        });
      }
    } else {
      var usercat = userDB.doc(username).collection('interacted_cats').doc(cat.title);

      await usercat.set({
        'isLiked': isLiked,
      });

      for(var elem in votedMedia.keys) {
        usercat.set({
          elem : votedMedia[elem],
        });
      }
    }
  }

  Future<bool> doesMediaExist(String id) async {
    var ref = await catDB.doc(id).get();
    return ref.exists;
  }

  updateCatListOnAddedMedia() async {

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

  getColorUpvote(String id){
    if(!votedMedia.containsKey(id)) {
        return const Color(0xFFD9D9D9);
    } else if (votedMedia[id]!) {
      return const Color(0xFF42A7AD);
    }
    else {
      return const Color(0xFFD9D9D9);
    }
  }

  getColorDownVote(String id){
    if(!votedMedia.containsKey(id)) {
      return const Color(0xFFD9D9D9);
    }
    else if (!votedMedia[id]!) {
      return const Color(0xFFEC6B76);
    }
    else {
      return const Color(0xFFD9D9D9);
    }
  }

  @override
  void initState(){
    super.initState();
    cat = widget.category;
    getAllCatInfo();
    loadCreatorName();
  }

  @override
  void dispose() {
    updateAllCatInfo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!isEditMode) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xff393d5a),

        bottomNavigationBar: BottomAppBar(
          color: const Color(0xCACBCBD2),
          child: IconTheme(
            data: const IconThemeData(color: Color(0xCB6D706B)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<
                          double> animation1, Animation<double> animation2) {
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
                      pageBuilder: (BuildContext context, Animation<
                          double> animation1, Animation<double> animation2) {
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
                        pageBuilder: (BuildContext context, Animation<
                            double> animation1, Animation<double> animation2) {
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
                      pageBuilder: (BuildContext context, Animation<
                          double> animation1, Animation<double> animation2) {
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
                      pageBuilder: (BuildContext context, Animation<
                          double> animation1, Animation<double> animation2) {
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
            Container(
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
                padding: EdgeInsets.all(MediaQuery.of(context).size.width/25.72),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 35.0,
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 6.5,
                      child: Stack(
                        children: [
                          Positioned(
                            right: MediaQuery.of(context).size.width/48.41,
                            bottom: 0,
                            child: getButtons(),
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

                              Text(
                                "by @$creatorUsername",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
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
                    const SizedBox(height: 9.0),
                    Container(
                      height: 0.9,
                      width: double.infinity,
                      color: const Color(0xFF6B6D7B),
                    ),
                    Expanded(
                      child: DraggableScrollableActuator(
                        child: ListView.builder(
                          itemCount: cat.catMedia.length,
                          itemBuilder: (context, index) =>
                              ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: IconButton(
                                                iconSize: 35,
                                                icon: const Icon(
                                                    MyFlutterApp.upvote),
                                                color: getColorUpvote(
                                                    cat.catMedia[index].id),
                                                onPressed: () {
                                                  if (!votedMedia.containsKey(
                                                      cat.catMedia[index].id)) {
                                                    setState(() {
                                                      votedMedia[cat
                                                          .catMedia[index].id] =
                                                      true;
                                                      cat.updown[cat
                                                          .catMedia[index]
                                                          .id]![0]++;
                                                      cat.interactions++;
                                                    });
                                                  } else if (votedMedia[cat
                                                      .catMedia[index].id]! ==
                                                      true) {
                                                    setState(() {
                                                      votedMedia.remove(
                                                          cat.catMedia[index]
                                                              .id);
                                                      cat.updown[cat
                                                          .catMedia[index]
                                                          .id]![0]--;
                                                      cat.interactions--;
                                                    });
                                                  }
                                                  else {
                                                    setState(() {
                                                      votedMedia[cat
                                                          .catMedia[index].id] =
                                                      true;
                                                      cat.updown[cat
                                                          .catMedia[index]
                                                          .id]![0]++;
                                                      cat.updown[cat
                                                          .catMedia[index]
                                                          .id]![1]--;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                                height: 17,
                                                child: Text(
                                                    "${cat.updown[cat
                                                        .catMedia[index]
                                                        .id]![0]}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    )
                                                )
                                            ),
                                            SizedBox(
                                              height: 50,
                                              child: IconButton(
                                                iconSize: 35,
                                                icon: const Icon(
                                                    MyFlutterApp.downvote),
                                                color: getColorDownVote(
                                                    cat.catMedia[index].id),
                                                onPressed: () {
                                                  if (!votedMedia.containsKey(
                                                      cat.catMedia[index].id)) {
                                                    setState(() {
                                                      votedMedia[cat
                                                          .catMedia[index].id] =
                                                      false;
                                                      cat.updown[cat
                                                          .catMedia[index]
                                                          .id]![1]++;
                                                      cat.interactions++;
                                                    });
                                                  } else if (votedMedia[cat
                                                      .catMedia[index].id]! ==
                                                      false) {
                                                    setState(() {
                                                      votedMedia.remove(
                                                          cat.catMedia[index]
                                                              .id);
                                                      cat.updown[cat
                                                          .catMedia[index]
                                                          .id]![1]--;
                                                      cat.interactions--;
                                                    });
                                                  }
                                                  else {
                                                    setState(() {
                                                      votedMedia[cat
                                                          .catMedia[index].id] =
                                                      false;
                                                      cat.updown[cat
                                                          .catMedia[index]
                                                          .id]![1]++;
                                                      cat.updown[cat
                                                          .catMedia[index]
                                                          .id]![0]--;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                          child: SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 5,
                                            height: (MediaQuery
                                                .of(context)
                                                .size
                                                .width / 5) * 3 / 2,
                                            child: Image(
                                              fit: BoxFit.fill,
                                              isAntiAlias: true,
                                              image: getPosterURL(
                                                  cat.catMedia[index]),
                                              semanticLabel: "${cat
                                                  .catMedia[index]
                                                  .mediaName}...",
                                              loadingBuilder: (context, child,
                                                  progress) {
                                                return progress == null
                                                    ? child
                                                    : const LinearProgressIndicator();
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: "${getTrimmedName(
                                                          cat
                                                              .catMedia[index])}\n",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 20)),
                                                  TextSpan(
                                                      text: cat.catMedia[index]
                                                          .description,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16)),
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
    } else {
      textLength = cat.description.length;
      descCat.text = cat.description;
      descCat.value.replaced(descCat.value.composing, cat.description);
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xff393d5a),

        appBar: AppBar(
          leadingWidth: double.infinity,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0x66D9D9D9),
          ),
          leading: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isEditMode = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size:35
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/1.37),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isEditMode = false;
                          cat.description = descCat.text.trim();
                        });
                      },
                      icon: const Icon(
                          Icons.check,
                          color: Colors.black,
                          size:35
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height/15,
          backgroundColor: const Color(0x66D9D9D9),
          elevation: 0.0,
        ),

        bottomNavigationBar: BottomAppBar(
          color: const Color(0xCACBCBD2),
          child: IconTheme(
            data: const IconThemeData(color: Color(0xCB6D706B)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<
                          double> animation1, Animation<double> animation2) {
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
                      pageBuilder: (BuildContext context, Animation<
                          double> animation1, Animation<double> animation2) {
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
                        pageBuilder: (BuildContext context, Animation<
                            double> animation1, Animation<double> animation2) {
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
                      pageBuilder: (BuildContext context, Animation<
                          double> animation1, Animation<double> animation2) {
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
                      pageBuilder: (BuildContext context, Animation<
                          double> animation1, Animation<double> animation2) {
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
            Container(
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 6.5,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 48,
                              height: 39,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xB3D9D9D9),
                              ),
                              child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        updateCatListOnAddedMedia();
                                        Navigator.push(
                                          context, PageRouteBuilder(
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation1,
                                              Animation<double> animation2) {
                                            return SearchCreateCat(cat: cat,);
                                          },
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration: Duration
                                              .zero,
                                        ),
                                        ).whenComplete(() =>
                                            setState(() {})
                                        );
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

                              Text(
                                "by @$creatorUsername",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
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
                    TextFormField(
                      key: const Key("categoryDescription"),
                      controller: descCat,
                      decoration: InputDecoration(
                        filled:true,
                        fillColor: const Color(0xFFD4D4DB),
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
                      maxLines: 3,
                    ),
                    const SizedBox(height: 9.0),
                    Container(
                      height: 0.9,
                      width: double.infinity,
                      color: const Color(0xFF6B6D7B),
                    ),
                    Expanded(
                      child: DraggableScrollableActuator(
                        child: ListView.builder(
                          itemCount: cat.catMedia.length,
                          itemBuilder: (context, index) =>
                              ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: IconButton(
                                                iconSize: 35,
                                                icon: const Icon(
                                                    MyFlutterApp.upvote),
                                                color: getColorUpvote(
                                                    cat.catMedia[index].id),
                                                onPressed: () {},
                                              ),
                                            ),
                                            SizedBox(
                                                height: 17,
                                                child: Text(
                                                    "${cat.updown[cat.catMedia[index].id]![0]}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    )
                                                )
                                            ),
                                            SizedBox(
                                              height: 50,
                                              child: IconButton(
                                                iconSize: 35,
                                                icon: const Icon(
                                                    MyFlutterApp.downvote),
                                                color: getColorDownVote(
                                                    cat.catMedia[index].id),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                          child: SizedBox(
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 5,
                                            height: (MediaQuery
                                                .of(context)
                                                .size
                                                .width / 5) * 3 / 2,
                                            child: Image(
                                              fit: BoxFit.fill,
                                              isAntiAlias: true,
                                              image: getPosterURL(
                                                  cat.catMedia[index]),
                                              semanticLabel: "${cat
                                                  .catMedia[index]
                                                  .mediaName}...",
                                              loadingBuilder: (context, child,
                                                  progress) {
                                                return progress == null
                                                    ? child
                                                    : const LinearProgressIndicator();
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: "${getTrimmedName(cat
                                                              .catMedia[index])}\n",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 20)),
                                                  TextSpan(
                                                      text: cat.catMedia[index]
                                                          .description,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16)),
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
}