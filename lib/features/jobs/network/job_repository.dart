import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart ' as http;
import 'package:kaamwalijobs_new/models/job_listing.dart';

import '../../../models/applyjobpost_model.dart';

final class JobRepository {
  Future<JobListing> getJobs({required int pageNo}) async {
    try {
      Dio dio = Dio();
      String url =
          'https://test.kaamwalijobs.com/API/Mobile_api/posted_job_list';

      var formData = FormData.fromMap({'page': pageNo});
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5831998',
          },
        ),
      );
      // Handling response
      if (response.statusCode == 200) {
        JobListing jobListing = JobListing.fromJson(response.data);
        return jobListing;
      } else {
        throw Exception("Failed to load candidates");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<Applyjobpost?> applyJobsPost(String name, String number, String email,
      String city, String jobsId) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://test.kaamwalijobs.com/API/Mobile_api/applyjobpost")
            .replace(queryParameters: queryParameters);

    final body = {
      'candidate_name': name,
      'phone_no': number,
      'email': email,
      'city': city,
      'jobpost_id': jobsId
    };

    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == '200') {
          return Applyjobpost.fromJson(data);
        }
      }
    } catch (e) {
      throw Exception();
    }

    return null;
  }
}
