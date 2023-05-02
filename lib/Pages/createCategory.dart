import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff393d5a),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
                onPressed: () {},
              ),
              IconButton(
                icon: Image.asset('images/catIcon.png'),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.category),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          Padding (
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Row(
                      children: const [
                        Text(
                          "Create  Your\nCategory",
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                  ),
                  const SizedBox( height:20.0),

                  Row(
                      children: const [
                        Text(
                          "Add movies, upvote and downvote them, \nand share it with your friends!",
                          style: TextStyle(
                              color: Color.fromARGB(215, 255, 255, 255),
                              fontSize: 16.5,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ]
                  ),

                  const SizedBox( height:10.0),

                  Container(
                    height: 1.0,
                    width: 1000.0,
                    color: Colors.grey,
                  ),

                  const SizedBox( height:10.0),
                  Row(
                      children: const [
                        Text(
                          "Name your category:",
                          style: TextStyle(
                              color: Color.fromARGB(215, 255, 255, 255),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ]
                  ),
                  const SizedBox( height:20.0),

                  TextField(
                    key: const Key("categoryName"),
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
                  const SizedBox( height: 26.0),

                  Row(
                      children: const [
                        Text(
                          "Write a Description:",
                          style: TextStyle(
                              color: Color.fromARGB(215, 255, 255, 255),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ]
                  ),
                  const SizedBox( height:20.0),

                  TextField(
                    key: const Key("categoryDescription"),
                    obscureText: true,
                    decoration: InputDecoration(
                      filled:true,
                      fillColor: const Color(0xFFFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: " Enter your description ...",
                    ),
                  ),
                  const SizedBox( height: 26.0),


                  Row(
                      children: const [
                        Text(
                          "Add films:",
                          style: TextStyle(
                              color: Color.fromARGB(215, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ]
                  ),
                  const SizedBox( height: 26.0),
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
                        onPressed: () async {
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
              )
          ),
        ],
      ),
    );
  }
}
