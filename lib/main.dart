// ignore_for_file: unnecessary_string_interpolations, duplicate_ignore, unused_element, prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Customer {
  dynamic id;
  String? name;
  dynamic age;
  Customer({this.id, this.name, this.age});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> colorCodes = <int>[600, 500, 100];
  List<Customer> customers = [
    Customer(id: 1, name: 'Customer1', age: 18),
    Customer(id: 2, name: 'Customer2', age: 18),
    Customer(id: 3, name: 'Customer3', age: 18),
    Customer(id: 4, name: 'Customer4', age: 18),
    Customer(id: 5, name: 'Customer5', age: 18),
    Customer(id: 1, name: 'Customer1', age: 18),
    Customer(id: 2, name: 'Customer2', age: 18),
    Customer(id: 3, name: 'Customer3', age: 18),
    Customer(id: 4, name: 'Customer4', age: 18),
    Customer(id: 5, name: 'Customer5', age: 18),
    Customer(id: 1, name: 'Customer1', age: 18),
    Customer(id: 2, name: 'Customer2', age: 18),
    Customer(id: 3, name: 'Customer3', age: 18),
    Customer(id: 4, name: 'Customer4', age: 18),
    Customer(id: 5, name: 'Customer5', age: 18),
  ];

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  void _addCustomer() {
    setState(() {
      customers.add(Customer(
          id: _idController.text,
          name: _nameController.text,
          age: _ageController.text));
    });
  }

  void _removeCustomer(int index) {
    setState(() {
      customers = List.from(customers)..removeAt(index);
    });
  }

  void _modelButtonAdd() {
    showModalBottomSheet(
      context: this.context,
      builder: (context) {
        return Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'id',
                hintText: 'Customer Name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'name',
                hintText: 'Customer Name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'age',
                hintText: 'Customer Name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
              controller: _ageController,
            ),
            RaisedButton(
              child: Text('save'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  _addCustomer();
                });
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Home Page"),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: customers.length,
            itemBuilder: (BuildContext context, int index) {
              final Customer cus = customers[index];
              return GestureDetector(
                onTap: () {
                  _modelButtonAdd();
                  _removeCustomer(index);
                },
                child: Column(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.green,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${cus.id}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${cus.name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  '${cus.age}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  _removeCustomer(index);
                                },
                                icon: Icon(
                                  CupertinoIcons.clear_circled,
                                  color: Colors.red.shade900,
                                  size: 30,
                                ))
                          ],
                        )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _modelButtonAdd();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
