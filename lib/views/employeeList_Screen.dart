import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/employee_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/view_models/employee_list_view_model.dart';
import 'package:flutter_application_1/data_sources/employee_services.dart';
import 'package:flutter_application_1/resources/widgets/slidable_widget.dart';

// class CompanyListScreen extends StatefulWidget {
//   @override
//   _CompanyListScreenState createState() => _CompanyListScreenState();
// }

// class _CompanyListScreenState extends State<CompanyListScreen> {
//   final homeService = CompanyService();
//   late Future<List<Company>> futureCompany;
//   List<Companys> items = [];
//   bool _isLoading = false;
//   late List listItems;
//   ScrollController _scrollController = ScrollController();
//   int _maxItems = 8;

//   @override
//   void initState() {
//     super.initState();
//     _fetchCompanyList();
//     listItems = List.generate(10, (i) => "Items : ${i + 1}");
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//           _scrollController.position.maxScrollExtent) {
//         _getMoreData();
//       }
//     });
//   }

//   _getMoreData() {
//     for (int i = _maxItems; i < _maxItems + 10; i++) {
//       listItems.add("Items : ${i + 1}");
//     }

//     _maxItems = _maxItems + 8;

//     setState(() {});
//   }

//   void _fetchCompanyList() async {
//     setState(() => _isLoading = true);

//     setState(() => _isLoading = false);
//     print('${items}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Company",
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//             controller: _scrollController,
//               itemCount: items.length,
//               itemBuilder: (context, i) {
//                 return Container(
//                   margin: EdgeInsets.only(top: 20.0),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         spreadRadius: 2,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   padding: EdgeInsetsDirectional.all(12.0),
//                   child: Row(
//                     children: [
//                       IconButton(onPressed: null, icon: Icon(Icons.person)),
//                       Text(
//                         '${items[i].ResultId}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       Text('${items[i].ClassA}'),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

class EmployeeListView extends StatelessWidget {
  final Employee employee;
  const EmployeeListView({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${employee.ResultId}",
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            "${employee.ItemTitle}",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(height: 4),
          Text(
            "${DateFormat("dd/MM/yyyy").format(DateFormat("yyyy-MM-dd").parse(employee.UpdatedTime))}",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final homeService = EmployeeService();
  List<Employee> homes = [];
  bool _isLoading = false;
  late List myList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 6;

  @override
  void initState() {
    super.initState();
    _getEvent();
    myList = List.generate(10, (i) => "Item : ${i + 1}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      myList.add("Item : ${i + 1}");
    }

    _currentMax = _currentMax + 6;

    setState(() {});
  }

  void _getEvent() async {
    setState(() => _isLoading = true);
    homes = await homeService.fetchCompany();
    setState(() => _isLoading = false);
    // print('.............${homes}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Employee',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        // itemExtent: 30,
        // itemCount: 80,
        itemCount: homes.length,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
          child: SlidableWidget(
            child: EmployeeListView(employee: homes[index]),
            onTap: () => {
              setState(() {
                homes.remove(homes[index]);
              })
            },
            onDismissed: (action) => dismissSlidableItem(context, true),
          ),
        ),
      ),
    );
  }
}

class Utils {
  static void showSnackBar(BuildContext context, bool check) =>
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            // margin: EdgeInsets.all(5),
            content: Row(
              children: const [
                Icon(
                  CupertinoIcons.delete_solid,
                  size: 22,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Text(
                  'Successful Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
}

void dismissSlidableItem(BuildContext context, bool check) {
  Utils.showSnackBar(context, check);
}

//       body: ListView.builder(
//         itemCount: companys.length,
//         itemBuilder: (context, index) {
//           final item = myList[index];
//           return Dismissible(
//             // Each Dismissible must contain a Key. Keys allow Flutter to
//             // uniquely identify widgets.
//             key: Key(item),
//             // Provide a function that tells the app
//             // what to do after an item has been swiped away.
//             onDismissed: (direction) {
//               // Remove the item from the data source.
//               setState(() {
//                 companys.removeAt(index);
//               });

//               // Then show a snackbar.
//               ScaffoldMessenger.of(context)
//                   .showSnackBar(SnackBar(content: Text('$item dismissed')));
//             },
//             // Show a red background as the item is swiped away.
//             background: Container(color: Colors.red),
//             child: ListTile(
//               title: Text(item),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
