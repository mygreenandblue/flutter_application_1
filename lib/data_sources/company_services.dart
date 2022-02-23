import 'dart:async';
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
    final resp = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: json.jsonEncode({'ApiKey': ApiUrls.apiKey}),
    );
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
      headers: {'Accept': 'application/json'},
      body: json.jsonEncode({'ApiKey': ApiUrls.apiKey}),
    );
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
