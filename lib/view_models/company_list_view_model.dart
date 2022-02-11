// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/models/company_model.dart';
// import 'package:flutter_application_1/views/companyList_Screen.dart';
import 'package:flutter_application_1/data_sources/company_services.dart';

class CompanyListViewModel with ChangeNotifier {
  final homeService = CompanyService();
  List<Company> homes = [];

  void getEvent() async {
    this.homes = await homeService.fetchCompany();
    notifyListeners();
    print('.............${homes}');
  }
}
