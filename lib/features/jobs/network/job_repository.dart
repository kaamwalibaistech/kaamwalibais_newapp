import 'package:dio/dio.dart';
import 'package:kaamwalijobs_new/models/job_listing.dart';

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
}
