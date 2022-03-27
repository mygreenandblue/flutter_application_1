import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/company_model.dart';
import 'package:flutter_application_1/view_models/company_list_view_model.dart';
import 'package:flutter_application_1/data_sources/company_services.dart';
// import 'package:flutter_application_1/resources/widgets/slidable_widgets.dart';
import 'package:flutter_application_1/views/employeeList_Screen.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/views/companyViews/create/create_company_view.dart';
import 'company_list.dart';
import 'package:flutter_application_1/views/companyViews/update/company_detail.dart';
import 'package:flutter_application_1/resources/widgets/shimmer_widget.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  _CompanyListScreenState createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  bool _isLoadingVertical = false;
  final homeService = CompanyService();
  List<Company> homes = [];
  List verticalData = [];

  final ScrollController _scrollController = ScrollController();
  final int _currentMax = 6;
  late final Company company;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isGetData = false;

  @override
  void initState() {
    _getEvent();
    super.initState();
  }

  void _loadMoreVertical() async {
    setState(() {
      _isLoadingVertical = true;
    });

    homes = await homeService.fetchCompany();

    verticalData
        .addAll(List.generate(_currentMax, (index) => homes.length + index));

    int e = homes.length - verticalData.length;

    if (e < _currentMax) {
      return;
    }

    setState(() {
      _isLoadingVertical = false;
    });
  }

  void _getEvent() async {
    setState(() {
      isGetData = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    _loadMoreVertical();
    setState(() {
      isGetData = false;
    });

    // setState(() {
    //   _isLoadingVertical = true;
    // });
    // await Future.delayed(const Duration(seconds: 2));
    // homes = await homeService.fetchCompany();
    // verticalData
    //     .addAll(List.generate(_currentMax, (index) => homes.length + index));

    // int e = homes.length - verticalData.length;

    // if (e < _currentMax) {
    //   return;
    // }

    // setState(() {
    //   _isLoadingVertical = false;
    // });
  }

  Widget buildBookingShimer() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const ShimmerWidget.rectangular(
                height: 100,
                width: 100,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerWidget.rectangular(
                    height: 14,
                    width: 180,
                  ),
                  SizedBox(height: 10),
                  ShimmerWidget.rectangular(
                    height: 10,
                    width: 110,
                  ),
                  SizedBox(height: 30),
                  ShimmerWidget.rectangular(
                    height: 10,
                    width: 30,
                  ),
                  SizedBox(height: 10),
                  ShimmerWidget.rectangular(
                    height: 10,
                    width: 70,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

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
      body: LazyLoadScrollView(
        scrollDirection: Axis.vertical,
        isLoading: _isLoadingVertical,
        onEndOfPage: () => _getEvent(),
        child: Scrollbar(
          child: isGetData
              ? ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return buildBookingShimer();
                  })
              : ListView(children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: verticalData.length,
                    itemBuilder: (context, index) {
                      final item = homes[index].ResultId.toString();
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 7.5),
                        child: Column(children: [
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CompanyDetailsScreen(
                                      company: homes[index],
                                      id: homes[index].ResultId,
                                      getState: _isLoadingVertical,
                                    );
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
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                              onDismissed: (direction) {
                                // Remove the item from the data source.
                                setState(() {
                                  homeService
                                      .deleteCompany(homes[index].ResultId);

                                  homes.removeAt(index);
                                });
                                print(homes[index].ResultId);
                                // Then show a snackbar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
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
                  _isLoadingVertical
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox.shrink(),
                ]),
        ),
      ),
//           //   Center(
      // child: Text(viewModel.title),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddCompanyScreen(getEvent: _isLoadingVertical)),
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
