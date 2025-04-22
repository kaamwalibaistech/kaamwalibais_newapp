import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/sortlisted_candidate_model.dart';

class MenuPageRepository {
  Future<Shortlistedcandidatemodel> getSortListedCandidate(
      sortType, candidate_id, flag, userId) async {
    Map<String, String> queryParameters = {};
    queryParameters.addAll({"API-KEY": dotenv.get('API-KEY')});

    Uri url =
        Uri.parse("https://kaamwalijobs.com/API/Mobile_api/sortlistcandidate");

    final body = {
      'candidate_id': candidate_id,
      'flag': flag,
      'UserId': userId,
      'sort_type': sortType,
    };
    try {
      final response =
          await http.post(url, headers: queryParameters, body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        Shortlistedcandidatemodel shortlistedcandidatemodel =
            Shortlistedcandidatemodel.fromJson(data);
        if (shortlistedcandidatemodel.status == 200) {
          return shortlistedcandidatemodel;
        } else {
          throw Exception();
        }
      }
    } catch (e) {
      throw Exception();
    }
    throw Exception();
  }
}
