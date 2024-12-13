import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwalijobs_new/models/employer_register_model.dart';
import 'package:kaamwalijobs_new/models/empolyer_register_modelotp.dart';

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
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse(
            "https://test.kaamwalijobs.com/API/Mobile_api/home_content_for_android")
        .replace(queryParameters: queryParameters);

    final body = {'mobile_no': number};

    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return Otp.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception();
    }

    // try {
    //   var headers = {
    //     'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5831998',
    //   };
    //   var request = http.MultipartRequest(
    //       'POST',
    //       Uri.parse(
    //           'https://test.kaamwalijobs.com/API/Mobile_api/sendsignupotp'));
    //   request.fields.addAll({'mobile_no': number});

    //   request.headers.addAll(headers);

    //   http.StreamedResponse response = await request.send();

    //   if (response.statusCode == 200) {
    //   } else {
    //     print(response.reasonPhrase);
    //   }
    // }
    // catch (e) {
    //   throw Exception();
    // }
    return null;
  }

  Future<EmployerRegisterModel?> getEmployerRegister(
      String number, String name, String password) async {
    try {
      // var headers = {
      //   'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5831998',
      // };
      var headers = {
        'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5831998',
        // 'Cookie': 'ci_session=17a45cd742a58c81e90a82d5d389c2c7f85fe563'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://test.kaamwalijobs.com/API/Mobile_api/user_signup'));
      request.fields
          .addAll({'mobile_no': number, 'name': name, 'password': password});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }
}
