import 'dart:convert';
import 'package:api_caling/homeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      List<Photos> photoModel = []; // Initialize the list here

      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(
          title: i['title'],
          url: i['url'],
          id: i['id'],
        );
        photoModel.add(photos); // Add to the list
      }
      return photoModel;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo API'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_circle_right_sharp), // Replace with your desired icon
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Photos>>(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No photos found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url),
                  ),
                  subtitle: Text('ID: ${snapshot.data![index].id}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Photos {
  final int id;
  final String title;
  final String url;

  Photos({required this.title, required this.url, required this.id});
}
