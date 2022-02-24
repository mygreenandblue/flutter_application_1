// import 'package:flutter/material.dart';

// import 'package:flutter_application_1/views/companyViews/companyList_Screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Home Screen',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         unselectedWidgetColor: Colors.blue,
//       ),
//       home: const CompanyListScreen(),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String ClassA) async {
  final response = await http.post(
    Uri.parse('http://ik1-422-43222.vs.sakura.ne.jp:8081/api/items/7/get'),
    headers: <String, String>{
      "Content-Type": "application/json",
      'Accept': 'application/json',
      "Cookie":
          ".AspNetCore.Session=CfDJ8FRUTHWGkNNNqzrM7vfVRc1nlvrHgTdzOs4h2BCqSsUec9rZCUDQkFrCRetoiqSEkk1nYvBL8vyX12H6vzkUeLleFA7boDfqHfZVlTzmAItR%2FyVTsX0MkmnZ3VBO8ciOy7a139FP00qIcHL1gJ%2FaNGl%2F%2FwuR7%2Bv27UsL7jggBD4O",
    },
    body: jsonEncode(<String, String>{
      'ClassA': ClassA,
      'ApiKey':
          '980acd35fb4e2dd70333330eb3b6127e15a60da3401275c1a779b022e6d79ab91c320ceddea3a6b4f9b7b86eb4752e90d95d2de9797a125c7413b2c69792c0d4',
          
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int ResultId;
  final String ClassA;

  const Album({required this.ResultId, required this.ClassA});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      ResultId: json['ResultId'],
      ClassA: json['ClassA'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.ClassA);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
