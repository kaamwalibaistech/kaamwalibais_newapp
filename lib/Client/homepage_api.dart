import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwalijobs_new/models/empolyer_registerotp_model.dart';

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
    // final url =
    //     Uri.parse("https://test.kaamwalijobs.com/API/Mobile_api/sendsignupotp");

    // final body = {
    //   "Mobile_no": number,
    // };
    try {
      // var uri = Uri.parse('http://localhost.com');
      var headers = {
        'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5831998',
        // 'Cookie': 'ci_session=1534355d9ddc428a766c22e5417da9b3790733dd'
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://test.kaamwalijobs.com/API/Mobile_api/sendsignupotp'));
      request.fields.addAll({'mobile_no': number});

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
