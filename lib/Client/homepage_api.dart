import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwalijobs_new/models/empolyer_register_model.dart';

import '../models/homepage_model.dart';

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

  Future<Otp?> getEmployerRegisterOtp(String number) async {
    Map<String, String> queryParameters = {};
    final url = Uri.parse(
            "https://test.kaamwalijobs.com/API/Mobile_api/home_content_for_android")
        .replace(queryParameters: queryParameters);
    final body = {
      "Mobile_no": number,
    };
    try {
      final resopnse =
          await http.post(url, headers: queryParameters, body: body);
      if (resopnse.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(resopnse.body);
        if (data['status'] == "200") {
          return Otp.fromJson(data);
        } else {
          return null;
        }
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }
}
