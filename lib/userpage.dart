// import 'dart:convert';
//
// import 'package:api_caling/Model/UserModel.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class Userpage extends StatefulWidget {
//   const Userpage({super.key});
//
//   @override
//   State<Userpage> createState() => _UserpageState();
// }
//
// class _UserpageState extends State<Userpage> {
//   List<UserModel> usermodel = [];
//
//   Future<List<UserModel>> getuserApi() async {
//     final response =
//         await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
//     var data = jsonDecode(response.body.toString());
//     if (response.statusCode == 200) {
//       for (Map i in data) {
//         usermodel.add(UserModel.fromJson(i));
//       }
//       return usermodel;
//     } else {
//       return usermodel;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('UserData'),
//         centerTitle: true,
//       ),
//       body: FutureBuilder(
//           future: getuserApi(),
//           builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
//             if (!snapshot.hasData) {
//               return CircularProgressIndicator();
//             } else {
//               return ListView.builder(
//                   itemCount: usermodel.length,
//                   itemBuilder: (context, index) {
//                     Card(
//                       child: Column(
//                         children: [
//                           ReusebleRow(
//                               title: 'Name',
//                               value: snapshot.data![index].name.toString()),
//                         ],
//                       ),
//                     );
//                   });
//             }
//           }),
//     );
//   }
// }
//
// class ReusebleRow extends StatelessWidget {
//   String title, value;
//
//   ReusebleRow({super.key, required this.title, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title),
//         Text(value),
//       ],
//     );
//   }
// }



import 'dart:convert';
import 'package:api_caling/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  Future<List<UserModel>> getuserApi() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return List<UserModel>.from(data.map((user) => UserModel.fromJson(user)));
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserData'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: getuserApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(color: Colors.amber,
                    child: Column(
                      children: [
                        ReusebleRow(
                          title: 'ID',
                          value: snapshot.data![index].id.toString(),
                        ),

                        ReusebleRow(
                          title: 'Name',
                          value: snapshot.data![index].name.toString(),
                        ),

                        ReusebleRow(
                          title: 'Username',
                          value: snapshot.data![index].username.toString(),
                        ),

                        ReusebleRow(
                          title: 'Email',
                          value: snapshot.data![index].email.toString(),
                        ),

                        ReusebleRow(
                          title: 'Phone',
                          value: snapshot.data![index].phone.toString(),
                        ),

                        ReusebleRow(
                          title: 'Website',
                          value: snapshot.data![index].website.toString(),
                        ),

                        ReusebleRow(
                          title: 'Address',
                          value: snapshot.data![index].address!.city.toString(),
                        ),

                        ReusebleRow(
                          title: 'Latitude',
                          value: snapshot.data![index].address!.geo!.lat.toString(),
                        ),

                        ReusebleRow(
                          title: 'Longitude',
                          value: snapshot.data![index].address!.geo!.lng.toString(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ReusebleRow extends StatelessWidget {
  final String title;
  final String value;

  const ReusebleRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
