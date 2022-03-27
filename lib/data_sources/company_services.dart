import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/company_model.dart';
// import 'dart:convert' as json;

import 'api_urls.dart';

class CompanyService {
  Future<List<Company>> fetchCompany() async {
    final response = await http.post(
      Uri.parse('${ApiUrls.apiCompany}/936/get'),
      headers: <String, String>{
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'ApiKey': ApiUrls.apiKey,
        "Offset": 0,
        "View": {
          "ColumnFilterHash": {},
          "ColumnSorterHash": {"ResultId": "desc"}
        },
      }),
    );
    dynamic result = json.decode(utf8.decode(response.bodyBytes));
    List data = result['Response']['Data'];
    List<Company> items = [];
    
    for (int i = 0; i < data.length; i++) {
      items.add(Company.fromJson(data[i]));
    }
    return items;
  }

  Future<Company> createCompany(Company data) async {
    final url = Uri.parse('${ApiUrls.apiCompany}/936/create');
    final resp = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'ApiKey': ApiUrls.apiKey,
        "Offset": 0,
        "View": {
          "ColumnFilterHash": {},
        },
        "ClassHash": {
          // "ClassA": data.ResultId,
          "ClassA": data.ClassA,
          "ClassB": data.DescriptionA
        }
      }),
    );
    if (resp.statusCode == 200) {
      return Company.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to create company.');
    }
  }

  Future<Company> updateCompany(Company data, int? id) async {
    final url = Uri.parse('${ApiUrls.apiCompany}/$id/update');
    final resp = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'ApiKey': ApiUrls.apiKey,
        "Offset": 0,
        "View": {
          "ColumnFilterHash": {},
        },
        "ClassHash": {"ClassA": data.ClassA, "ClassB": data.DescriptionA}
        //  "ClassHash": {"ClassE": data.ClassA, "ClassF": data.DescriptionA}
      }),
    );
    if (resp.statusCode == 200) {
      return Company.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to update company.');
    }
  }

  Future<Company> deleteCompany(int? id) async {
    final url = Uri.parse('${ApiUrls.apiCompany}/$id/delete');
    final resp = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'ApiKey': ApiUrls.apiKey,
        "Offset": 0,
        "View": {
          "ColumnFilterHash": {},
        },
      }),
    );
    if (resp.statusCode == 200) {
      return Company.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to delete company.');
    }
  }
}
