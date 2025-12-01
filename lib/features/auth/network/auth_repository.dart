import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwalijobs_new/models/categorylist.dart';

import '../../../Client/homepage_api.dart';
import '../../../models/employer_edit_profile.dart';
import '../../../models/employer_forget_password_model.dart';
import '../../../models/employer_register_model.dart';
import '../../../models/empolyer_registerotp_model.dart';
import '../../../models/updated_profile.dart';

class AuthRepository {
  Future<EmployerRegisterModel?> userLogin(
      String number, String password, USER user) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/user_login")
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

  Future<UserUpdatedprofilemodel?> getUserUpatedProfile(
      String userId, String flag) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/userprofile")
        .replace(queryParameters: queryParameters);
    final body = {'UserId': userId, 'flag': flag};
    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == '200') {
          return UserUpdatedprofilemodel.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception();
    }
    return null;
  }

  // Future<EmployerRegisterModel?> candidateUserLogin(
  //     String number, String password, USER user) async {
  //   Map<String, String> queryParameters = {};
  //   queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

  //   Uri url =
  //       Uri.parse("https://test.kaamwalijobs.com/API/Mobile_api/user_login")
  //           .replace(queryParameters: queryParameters);
  //   final body = {
  //     'mobile_no': number,
  //     'password': password,
  //     'flag': user == USER.candidates ? '1' : '0'
  //   };
  //   try {
  //     final request = http.MultipartRequest("POST", url);
  //     request.fields.addAll(body);
  //     request.headers.addAll(queryParameters);
  //     final response = await request.send();

  //     if (response.statusCode == 200) {
  //       var res = await http.Response.fromStream(response);
  //       final result = jsonDecode(res.body) as Map<String, dynamic>;

  //       EmployerRegisterModel candidateRegisterModel =
  //           EmployerRegisterModel.fromJson(result);
  //       if (candidateRegisterModel.status == "200") {
  //         return candidateRegisterModel;
  //       }
  //       throw Exception();
  //     } else {
  //       throw Exception();
  //     }
  //   } catch (e) {
  //     throw Exception();
  //   }
  // }

  Future postCandidateFormData(
      String name,
      String number,
      String email,
      String password,
      List<String> category,
      String maritalStatus,
      String age,
      String religion,
      String gender,
      String passport,
      String education,
      String workingHrs,
      String location,
      String expectedSalary,
      String totalExperience,
      String language) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://kaamwalijobs.com/API/Mobile_api/apply_jobform");

    final body = {
      'Name': name,
      'MobileNo': number,
      'password': password,
      'Category': category.join(','),
      'MaritalStatus': maritalStatus,
      'EmailId': email,
      'language': language,
      'Age': age,
      'Religion': religion,
      'Gender': gender,
      'Passport': passport,
      'MaximumEducation': education,
      'WorkingHours': workingHrs,
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
        return result;
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

  Future<Otp?> getEmployerRegisterOtp(String number) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/sendsignupotp")
        .replace(queryParameters: queryParameters);

    final body = {'mobile_no': number};

    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return Otp.fromJson(data);
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

    Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/user_signup")
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

  Future<EmployerforgetpasswordModel?> getEmployerRegisterForgetPasswordOtp(
      String number) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/sendforgototp")
        .replace(queryParameters: queryParameters);

    final body = {'mobile_no': number};

    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == '200') {
          return EmployerforgetpasswordModel.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception();
    }

    return null;
  }

  Future<void> getEmployerRegisterNewPassword(
      String number, String newPassword) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/restpassword")
        .replace(queryParameters: queryParameters);

    final body = {'mobile_no': number, 'new_password': newPassword};

    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == '200') {
          return data['msg'];
        }
      }
    } catch (e) {
      throw Exception();
    }

    return null;
  }

  Future<Categorylistmodel> getcategorynameid() async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/categorylist1")
        .replace(queryParameters: queryParameters);

    // final body = {'mobile_no': number, 'new_password': newPassword};

    try {
      final response = await http.get(
        url,
        headers: queryParameters,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return Categorylistmodel.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception();
    }

    return throw Exception();
  }

  Future<EmployerProfileEdit?> updateUserProfile(
      name, number, email, flag, userid) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://kaamwalijobs.com/API/Mobile_api/userprofile_update")
            .replace(queryParameters: queryParameters);

    final body = {
      'Name': name,
      'MobileNo': number,
      'EmailId': email,
      'flag': flag,
      'UserId': userid
    };

    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == '200') {
          return EmployerProfileEdit.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return throw Exception();
  }
}
