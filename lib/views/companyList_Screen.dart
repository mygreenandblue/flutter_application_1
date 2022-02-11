import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/company_model.dart';
import 'package:flutter_application_1/view_models/company_list_view_model.dart';
import 'package:flutter_application_1/data_sources/company_services.dart';
// import 'package:flutter_application_1/resources/widgets/slidable_widgets.dart';
import 'package:flutter_application_1/views/employeeList_Screen.dart';
import 'package:provider/provider.dart';

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

class CompanyListView extends StatelessWidget {
  final Company company;
  const CompanyListView({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
            "${company.ResultId}",
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(
            "${company.DescriptionA}",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(height: 4),
          Text(
            "${company.DescriptionA}",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  _CompanyListScreenState createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  final homeService = CompanyService();
  List<Company> homes = [];
  bool _isLoading = false;
  late List myList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 6;

  @override
  void initState() {
    super.initState();
    // Provider.of<CompanyListViewModel>(context, listen: false).getEvent();
    // _getEvent();
    // myList = List.generate(10, (i) => "Item : ${i + 1}");
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     _getMoreData();
    //   }
    // });
  }

  // // _getMoreData() {
  // //   for (int i = _currentMax; i < _currentMax + 10; i++) {
  // //     myList.add("Item : ${i + 1}");
  // //   }

  // //   _currentMax = _currentMax + 6;

  // //   setState(() {});
  // // }

  // void _getEvent() async {
  //   setState(() => _isLoading = true);
  //   homes = await homeService.fetchCompany();
  //   setState(() => _isLoading = false);
  //   // print('.............${homes}');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Company',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
// //       body: ListView.builder(
// //         controller: _scrollController,
// //         itemCount: homes.length,
// //         itemBuilder: (context, index) => Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
// //           child: GestureDetector(
// //             onTap: () => {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (context) => EmployeeListScreen()),
// //               ),
// //             },
// //             child: SlidableWidget(
// //               child: CompanyListViewModel(company: homes[index]),
// //               onTap: () => {
// //                 setState(() {
// //                   homes.remove(homes[index]);
// //                 })
// //               },
// //               onDismissed: (action) => dismissSlidableItem(context, true),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

      body: ListView.builder(
        controller: _scrollController,
        itemCount: homes.length,
        itemBuilder: (context, index) {
          final item = homes[index].ClassA as String;
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployeeListScreen()),
                ),
              },
              child: Dismissible(
                child: CompanyListView(company: homes[index]),
                // Each Dismissible must contain a Key. Keys allow Flutter to
                // uniquely identify widgets.
                key: Key(item),
                // Provide a function that tells the app
                // what to do after an item has been swiped away.
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    homes.removeAt(index);
                  });

                  // Then show a snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
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
                  ));
                },
                // Show a red background as the item is swiped away.
                background: Container(color: Colors.red),
                // child: ListTile(
                //   title: Text(item),
                // ),
              ),
            ),
          );
        },
      ),
//           //   Center(
      // child: Text(viewModel.title),
    );
  }
}

// class Utils {
//   static void showSnackBar(BuildContext context, bool check) =>
//       Scaffold.of(context)
//         ..hideCurrentSnackBar()
//         ..showSnackBar(
//           SnackBar(
//             backgroundColor: Colors.red,
//             content: Row(
//               children: const [
//                 Icon(
//                   CupertinoIcons.delete_solid,
//                   size: 22,
//                   color: Colors.white,
//                 ),
//                 SizedBox(width: 12),
//                 Text(
//                   'Successful Delete',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
// }

// void dismissSlidableItem(BuildContext context, bool check) {
//   Utils.showSnackBar(context, check);
// }
