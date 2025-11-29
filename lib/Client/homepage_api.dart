import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwalijobs_new/models/packages_model.dart';

import '../models/current_package_plan.dart';
import '../models/homepage_model.dart';
import '../models/purchasepackagejob_model.dart';
import '../models/transcation_model.dart';

enum USER { employer, candidates }

class Repositiory {
  Future<Homepagemodel> getHomePageData() async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});
    // Map<String, String> header = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    // };
    final body = {'latitude': "", 'longitude': ""};
    Uri url = Uri.parse(
        "https://kaamwalijobs.com/API/Mobile_api/home_content_for_android");

    try {
      final response =
          await http.post(url, body: body, headers: queryParameters);
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

    Uri url = Uri.parse("https://kaamwalijobs.com/API/Mobile_api/packageplan")
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

  Future<CurrentPackagePlan> getCurrentPackages(userId) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url = Uri.parse(
        "https://kaamwalijobs.com/API/Mobile_api/current_candidate_package");

    final body = {
      'UserId': userId,
    };
    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return CurrentPackagePlan.fromJson(data);
      }
    } catch (e) {
      throw Exception();
    }
    throw Exception();
  }

  Future<PurchasedpackagesJob> getCurrentJobPackages(userId) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://kaamwalijobs.com/API/Mobile_api/job_package_status");

    final body = {
      'UserId': userId,
    };
    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return PurchasedpackagesJob.fromJson(data);
      }
    } catch (e) {
      throw Exception();
    }
    throw Exception();
  }

  Future<RazorpaytranscationModel?> getTransactionstatus(
      userId, razorpayId, price, packageId, orderId, signature) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://kaamwalijobs.com/API/Mobile_api/transactionstatus");

    final body = {
      'UserId': userId,
      'razorpay_payment_id': razorpayId,
      'price': price,
      'PackageId': packageId,
      'razorpay_order_id': orderId,
      'razorpay_signature': signature,
    };
    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return RazorpaytranscationModel.fromJson(data);
      }
    } catch (e) {
      // throw Exception();
      // return null;
    }
    // throw Exception();
    return null;
  }
}
