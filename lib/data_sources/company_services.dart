import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/company_model.dart';
import 'dart:convert' as json;

import 'api_urls.dart';

class CompanyService {
  Future<List<Company>> fetchCompany() async {
    final url = Uri.parse(ApiUrls.apiCompany);
    final resp = await http.post(
      url,
      headers: {'Cookie': 'application/json'},
      body: json.jsonEncode({'ApiKey': ApiUrls.apiKey}),
    );
    final decodedData = json.jsonDecode(resp.body);
    final peliculas = Companys.fromJsonList(decodedData['Response']['Data']);
    return peliculas.items;
  }

  Future<bool> createCompany(Company data) async {
    final url = Uri.parse(ApiUrls.apiCompany);
    final resp = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Cookie":
              ".AspNetCore.Session=CfDJ8FRUTHWGkNNNqzrM7vfVRc1nlvrHgTdzOs4h2BCqSsUec9rZCUDQkFrCRetoiqSEkk1nYvBL8vyX12H6vzkUeLleFA7boDfqHfZVlTzmAItR%2FyVTsX0MkmnZ3VBO8ciOy7a139FP00qIcHL1gJ%2FaNGl%2F%2FwuR7%2Bv27UsL7jggBD4O",
        },
        body: json.jsonEncode({'ApiKey': ApiUrls.apiKey}),
        encoding: Encoding.getByName("utf-8"));
    if (resp.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateCompany(Company data) async {
    final url = Uri.parse(ApiUrls.apiCompany);
    final resp = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: json.jsonEncode({'ApiKey': ApiUrls.apiKey}),
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCompany(int id) async {
    final url = Uri.parse(ApiUrls.apiCompany);
    final resp = await http.delete(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: json.jsonEncode({'ApiKey': ApiUrls.apiKey}),
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
