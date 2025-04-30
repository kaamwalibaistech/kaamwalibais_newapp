import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../models/candidate_request.dart';
import '../../../models/job_post_count_minus.dart';
import '../../../models/search_candidate_model.dart';

class NavRepositiory {
  Future<Jobpostcountminus> getJobPostCount(
    String categoryvalue,
    String locationController,
    String jobShiftvalue,
    String scheduleValue,
    String genderValue,
    String religionValue,
    String age,
    String marriedvalue,
    String educationValue,
    String languageValue,
    String experienceValue,
    String minimumPaymentController,
    String maximumPaymentController,
    String userId,
  ) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});
    Uri url =
        Uri.parse("https://kaamwalijobs.com/API/Mobile_api/create_jobpost");

    final body = {
      'CategoryId': categoryvalue,
      'job_location': locationController,
      'job_type': jobShiftvalue,
      'schedule': scheduleValue,
      'Gender': genderValue,
      'Religion': religionValue,
      'Age': age,
      'Marital_Status': marriedvalue,
      'Education': educationValue,
      'Languages': languageValue,
      'Experience': experienceValue,
      'minimum_price': minimumPaymentController,
      'maximum_price': maximumPaymentController,
      'UserId': userId,
    };

    final response = await http.post(url, headers: queryParameters, body: body);
    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == '200') {
          return Jobpostcountminus.fromJson(data);
          // Parse the JSON response
        } else if (data['status'] == '201') {
          return Jobpostcountminus.fromJson(data);
        }
        ;
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  Future<SearchCandidateModel> getAvailableCandidates(
      {required CandidateRequest candidateRequest}) async {
    try {
      Dio dio = Dio();
      String url =
          "https://kaamwalijobs.com/API/Mobile_api/search_candidate_list";

      // Format the request parameters
      Map<String, dynamic> requestData = {
        'CategoryId': candidateRequest.categoryId ?? '',
        'UserId': candidateRequest.userId ?? '',
        'page': candidateRequest.page ?? '1',
        'latitude': candidateRequest.latitude ?? '',
        'longitude': candidateRequest.longitude ?? '',
        'km': candidateRequest.km ?? '3',
        'min_salry': candidateRequest.minSalry ?? '',
        'max_salary': candidateRequest.maxSalary ?? '',
        'passport': candidateRequest.passport ?? '',
        'min_age': candidateRequest.minAge ?? '',
        'max_age': candidateRequest.maxAge ?? '',
        'min_exp': candidateRequest.minExp ?? '',
        'max_exp': candidateRequest.maxExp ?? '',
        'gender': candidateRequest.gender ?? '',
        'working_hours': candidateRequest.workingHours ?? '',
        'religon': candidateRequest.religon ?? '',
        'language': candidateRequest.language ?? '',
        'sort_by': candidateRequest.sortBy ?? '',
      };

      // Remove empty parameters
      requestData.removeWhere((key, value) => value == '');

      var formData = FormData.fromMap(requestData);

      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5831998',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        SearchCandidateModel searchCandidateModel =
            SearchCandidateModel.fromJson(response.data);
        return searchCandidateModel;
      } else {
        throw Exception("Failed to load candidates");
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception("Network error: ${e.message}");
      } else {
        throw Exception("Error: $e");
      }
    }
  }
}
