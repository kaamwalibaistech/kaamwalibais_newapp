// import 'package:bloc/bloc.dart';
// import 'package:kaamwalijobs_new/features/jobs/network/job_repository.dart';
// import 'package:kaamwalijobs_new/features/navigation/bloc/applicants_events.dart';
// import 'package:kaamwalijobs_new/features/navigation/bloc/applicants_state.dart';

// class ApplicantsBloc extends Bloc<ApplicantsEvents, ApplicantState> {
//   ApplicantsBloc() : super(ApplicantInitialState()) {
//     on<ApplicantsEvents>(_getApplicantList);
//   }

//   String? errorMessage;

//   Future<void> _getApplicantList(
//       ApplicantsEvents event, Emitter<ApplicantState> emit) async {
//     try {
//       final jobRepository = JobRepository();
//       final applyCandidateList =
//           await jobRepository.getApplyCandidateList(event);
//     } catch (e) {
//       errorMessage = 'Failed to load candidates: ${e.toString()}';
//     }
//   }
// }
