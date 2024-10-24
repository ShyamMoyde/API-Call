import 'dart:convert';

import 'package:api_caling/Model/PostModel.dart';
import 'package:api_caling/userpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));

      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.amber,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_circle_right_sharp), // Replace with your desired icon
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Userpage()));
            },
          ),
        ],
        title: Text('API'),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Loding...');
                    } else {
                      return ListView.builder(itemCount: postList.length,
                          itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(postList[index].title.toString()),
                            Text(postList[index].body.toString()),
                          ],
                        );
                      });
                    
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
