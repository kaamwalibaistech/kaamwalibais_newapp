import 'package:dio/dio.dart';

import '../../../models/candidate_request.dart';
import '../../../models/search_candidate_model.dart';

/*
Future<SearchCandidateModel> getAvailableCandidates(
    String CategoryId,
    String UserId,
    String page,
    String latitude,
    String longitude,
    String km,
    String min_salry,
    String max_salary,
    String passport,
    String min_age,
    String max_age,
    String min_exp,
    String max_exp,
    String gender,
    String working_hours,
    String religon,
    String language,
    String sort_by) async {
  Map<String, String> queryParameters = {};
  queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});
  Uri url = Uri.parse(
          "https://test.kaamwalijobs.com/API/Mobile_api/search_candidate_list")
      .replace(queryParameters: queryParameters);

  final body = {
    'CategoryId': CategoryId,
    'UserId': UserId,
    'page': page,
    'latitude': latitude,
    'longitude': longitude,
    'km': km,
    'min_salry': min_salry,
    'max_salary': max_salary,
    'passport': passport,
    'min_age': min_age,
    'max_age': max_age,
    'min_exp': min_exp,
    'max_exp': max_exp,
    'gender': gender,
    'working_hours': working_hours,
    'religon': religon,
    'language': language,
    'sort_by': sort_by,
  };

  final response = await http.post(url, headers: queryParameters, body: body);
  try {
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return SearchCandidateModel.fromJson(data);
        // Parse the JSON response
      } else if (data['status'] == 'error')
        return SearchCandidateModel.fromJson(data);
    }
    throw Exception();
  } catch (e) {
    throw Exception();
  }
}
*/

Future<SearchCandidateModel> getAvailableCandidates(
    {required CandidateRequest candidateRequest}) async {
  try {
    Dio dio = Dio();
    String url =
        "https://test.kaamwalijobs.com/API/Mobile_api/search_candidate_list";
    print(candidateRequest.toJson().toString());
    var formData = FormData.fromMap(candidateRequest.toJson());
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
