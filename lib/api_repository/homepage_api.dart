import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/homepage_model.dart';

class Repositiory {
  Future<Homepagemodel?> getHomePageData() async {
    final response = await http.get(Uri.parse(
        "https://test.kaamwalijobs.com/API/Mobile_api/home_content_for_android?API-KEY=ea3652c8-d890-44c6-9789-48dfc5831998"));

    try {
      if (response.statusCode == 200) {
        Homepagemodel homepageapi =
            Homepagemodel.fromJson(jsonDecode(response.body));
        return homepageapi;
      } else {
        return null;
      }
    } catch (e) {}
    return null;
  }
}
