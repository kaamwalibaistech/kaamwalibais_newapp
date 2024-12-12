import 'package:dio/dio.dart';
import 'package:kaamwalijobs_new/models/candidate_request.dart';

import '../../../models/candidate_model.dart';

class DashboardNetwork {
  Future<CandidateModel> fetchCandidates(
      {required CandidateRequest candidateRequest}) async {
    try {
      Dio dio = Dio();
      String url =
          'https://test.kaamwalijobs.com/API/Mobile_api/all_candidate_list';
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
      if (response.statusCode == 200) {
        CandidateModel candidateModel = CandidateModel.fromJson(response.data);
        return candidateModel;
      } else {
        throw Exception("Failed to load candidates");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
