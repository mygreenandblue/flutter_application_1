import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/company_model.dart';
import 'package:flutter_application_1/view_models/company_list_view_model.dart';
import 'package:flutter_application_1/data_sources/company_services.dart';
// import 'package:flutter_application_1/resources/widgets/slidable_widgets.dart';
import 'package:flutter_application_1/views/employeeList_Screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/views/companyViews/create/create_company_view.dart';
import 'package:flutter_application_1/views/companyViews/companyList_Screen.dart';

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
  final Company? company;
  const CompanyListView({Key? key, this.company}) : super(key: key);

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
            "${company!.ResultId}",
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            "${company!.ClassA}",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            "${company!.DescriptionA}",
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
