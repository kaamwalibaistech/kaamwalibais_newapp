import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/features/jobs/bloc/job_event.dart';
import 'package:kaamwalijobs_new/features/jobs/network/job_repository.dart';
import 'package:kaamwalijobs_new/models/job_listing.dart';

import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobBloc(this._jobRepository) : super(JobInitial()) {
    on<GetJobs>(_getJobs);
  }
  final JobRepository _jobRepository;

  void _getJobs(GetJobs event, Emitter<JobState> emit) async {
    try {
      JobListing successResponse =
          await _jobRepository.getJobs(pageNo: event.pageNo);

      emit(JobListLoadedState(job: successResponse.data ?? []));
    } catch (e) {
      emit(JobFailedState());
    }
  }
}
