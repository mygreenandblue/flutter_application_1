import 'dart:async';
import 'package:flutter_application_1/data_sources/api_urls.dart';
import 'package:flutter_application_1/models/employee_model.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as json;


class EmployeeService {
  Future<List<Employee>> fetchCompany() async {
    final url = Uri.parse(ApiUrls.apiEmployee);
    final resp = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: json.jsonEncode({'ApiKey': ApiUrls.apiKey}),
    );
    final decodedData = json.jsonDecode(resp.body);
    final peliculas = Employees.fromJsonList(decodedData['Response']['Data']);
    return peliculas.items;
  }
}
