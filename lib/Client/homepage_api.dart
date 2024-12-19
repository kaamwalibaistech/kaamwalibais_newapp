import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwalijobs_new/models/employer_register_model.dart';
import 'package:kaamwalijobs_new/models/packages_model.dart';

import '../models/empolyer_registerotp_model.dart';
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

  Future<Otp?> getEmployerRegisterOtp(String number) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://test.kaamwalijobs.com/API/Mobile_api/sendsignupotp")
            .replace(queryParameters: queryParameters);

    final body = {'mobile_no': number};

    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == '200') {
          return Otp.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception();
    }

    return null;
  }

  Future<EmployerRegisterModel?> getEmployerRegister(
      String name, String number, String email, String password) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://test.kaamwalijobs.com/API/Mobile_api/user_signup")
            .replace(queryParameters: queryParameters);
    final body = {
      'name': name,
      'mobile_no': number,
      'emaild': email,
      'password': password,
    };
    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == '200') {
          return EmployerRegisterModel.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }

  Future<EmployerRegisterModel?> userLogin(
      String number, String password, USER user) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://test.kaamwalijobs.com/API/Mobile_api/user_login")
            .replace(queryParameters: queryParameters);
    final body = {
      'mobile_no': number,
      'password': password,
      'flag': user == USER.employer ? '0' : '1'
    };
    try {
      final request = http.MultipartRequest("POST", url);
      request.fields.addAll(body);
      request.headers.addAll(queryParameters);
      final response = await request.send();

      if (response.statusCode == 200) {
        var res = await http.Response.fromStream(response);
        final result = jsonDecode(res.body) as Map<String, dynamic>;
        EmployerRegisterModel employerRegisterModel =
            EmployerRegisterModel.fromJson(result);
        return employerRegisterModel;
      } else {
        throw Exception();
      }
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
