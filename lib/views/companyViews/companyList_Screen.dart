import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/company_model.dart';
import 'package:flutter_application_1/view_models/company_list_view_model.dart';
import 'package:flutter_application_1/data_sources/company_services.dart';
// import 'package:flutter_application_1/resources/widgets/slidable_widgets.dart';
import 'package:flutter_application_1/views/employeeList_Screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/views/companyViews/create/create_company_view.dart';
import 'company_list.dart';
import 'package:flutter_application_1/views/companyViews/update/company_detail.dart';

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
  late final Company company;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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

  // void _modelButtonAdd() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Column(
  //         children: [
  //           TextField(
  //             controller: _idController,
  //             decoration: InputDecoration(
  //               labelText: company!.ResultId.toString(),
  //               hintText: 'Customer Name',
  //               hintStyle: TextStyle(
  //                 color: Colors.grey,
  //               ),
  //               border: InputBorder.none,
  //             ),
  //           ),
  //           TextField(
  //             controller: _classController,
  //             decoration: InputDecoration(
  //               labelText: company!.ClassA.toString(),
  //               hintText: 'Customer Name',
  //               hintStyle: TextStyle(
  //                 color: Colors.grey,
  //               ),
  //               border: InputBorder.none,
  //             ),
  //           ),
  //           TextField(
  //             decoration: InputDecoration(
  //               labelText: company!.DescriptionA.toString(),
  //               hintText: 'Customer Name',
  //               hintStyle: TextStyle(
  //                 color: Colors.grey,
  //               ),
  //               border: InputBorder.none,
  //             ),
  //             controller: _descriptionController,
  //           ),
  // RaisedButton(
  //   child: Text('save'),
  //   onPressed: () {
  //     setState(() {
  //       Navigator.of(context).pop();
  //       _addCustomer();
  //     });
  //   },
  // )
  //         ],
  //       );
  //     },
  //   );
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
        // actions: <Widget>[
        //   GestureDetector(
        //     onTap: () async {
        //       var result = await Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => AddCompanyScreen()),
        //       );
        //       if (result != null) {
        //         setState(() {});
        //       }
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 16.0),
        //       child: Icon(
        //         Icons.add,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ],
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
          final item = homes[index].ResultId.toString();

          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
            child: Column(children: [
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CompanyDetailsScreen(company: homes[index]);
                      },
                    ),
                  );
                  // _modelButtonAdd()
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
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      homes.indexOf(homes[index]);
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
            ]),
          );
        },
      ),
//           //   Center(
      // child: Text(viewModel.title),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCompanyScreen()),
          );
          if (result != null) {
            setState(() {});
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
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
