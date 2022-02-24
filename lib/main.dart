import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Company {
  final int id;
  final String name;

  const Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['ResultId'],
      name: json['ClassA'],
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
  List<Company> companies = [];

  Future<List<Company>> getCompanies() async {
    final response = await http.post(
      Uri.parse('http://ik1-422-43222.vs.sakura.ne.jp:8081/api/items/7/get'),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "ApiKey":
            "980acd35fb4e2dd70333330eb3b6127e15a60da3401275c1a779b022e6d79ab91c320ceddea3a6b4f9b7b86eb4752e90d95d2de9797a125c7413b2c69792c0d4",
        "Offset": 0,
        "View": {
          "ColumnFilterHash": {},
          "ColumnSorterHash": {"ResultId": "desc"}
        },
      }),
    );
    dynamic result = jsonDecode(response.body);
    List data = result['Response']['Data'];
    List<Company> items = [];
    for (int i = 0; i < data.length; i++) {
      items.add(Company.fromJson(data[i]));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    getCompanies().then((value) => setState(() {
          companies.addAll(value);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Company',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Company')),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: companies.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(companies[index].id.toString()),
                    Text(companies[index].name),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
