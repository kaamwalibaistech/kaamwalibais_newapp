import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../Client/homepage_api.dart';
import '../../../models/employer_register_model.dart';

class AuthRepository {
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

  Future postCandidateFormData(
      String name,
      String number,
      String email,
      String password,
      String category,
      String maritalStatus,
      String age,
      String religion,
      String gender,
      String passport,
      String education,
      String timing,
      String workingHrs,
      String address,
      String location,
      String expectedSalary,
      String totalExperience,
      String language) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://test.kaamwalijobs.com/API/Mobile_api/apply_jobform");

    final body = {
      'Name': name,
      'MobileNo': number,
      'password': password,
      'Category': category,
      'MaritalStatus': maritalStatus,
      'EmailId': email,
      'language': language,
      'Age': age,
      'Religion': religion,
      'Gender': gender,
      'Passport': passport,
      'MaximumEducation': education,
      'shift': timing,
      'WorkingHours': workingHrs,
      'ContactAddress': address,
      'ServiceLocation': location,
      'ExpectedSalary': expectedSalary,
      'TotalExp': totalExperience,
    };

    // final response = await request.send();

    try {
      final request = http.MultipartRequest("POST", url);
      request.fields.addAll(body);
      request.headers.addAll(queryParameters);
      final response = await request.send();

      if (response.statusCode == 200) {
        var res = await http.Response.fromStream(response);
        final result = jsonDecode(res.body) as Map<String, dynamic>;
        // EmployerRegisterModel employerRegisterModel =
        //     EmployerRegisterModel.fromJson(result);
      } else {
        throw Exception();
      }
      // final response =
      //     await http.post(url, headers: queryParameters, body: body);
      // if (response.statusCode == 200) {
      //   final Map<String, dynamic> data = jsonDecode(response.body);
      //   if (data['status'] == '200') {
      //     // return EmployerRegisterModel.fromJson(data);
      //   }
      // }
    } catch (e) {
      throw Exception();
    }
  }
}
