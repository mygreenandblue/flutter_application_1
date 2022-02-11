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
      headers: {'Accept': 'application/json'},
      body: json.jsonEncode({'ApiKey': ApiUrls.apiKey}),
    );
    final decodedData = json.jsonDecode(resp.body);
    final peliculas = Companys.fromJsonList(decodedData['Response']['Data']);
    return peliculas.items;
  }
}
