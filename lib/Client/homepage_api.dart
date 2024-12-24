import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwalijobs_new/models/packages_model.dart';

import '../models/homepage_model.dart';

enum USER { employer, candidates }

class Repositiory {
  Future<Homepagemodel> getHomePageData() async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse(
            "https://test.kaamwalijobs.com/API/Mobile_api/home_content_for_android")
        .replace(queryParameters: queryParameters);

    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        Homepagemodel homepageapi =
            Homepagemodel.fromJson(jsonDecode(response.body));
        return homepageapi;
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  Future<PackagesModel> getPackages() async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://test.kaamwalijobs.com/API/Mobile_api/packageplan")
            .replace(queryParameters: queryParameters);

    try {
      final response = await http.post(
        url,
        headers: queryParameters,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return PackagesModel.fromJson(data);
      }
    } catch (e) {
      throw Exception();
    }
    throw Exception();
  }
}
