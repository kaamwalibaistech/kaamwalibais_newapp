import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/candidate_model.dart';
import '../network/dashboard_network.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardNetwork dashboardNetwork;
  DashboardBloc({required this.dashboardNetwork})
      : super(DashboardStateInitial()) {
    on<GetCandidates>(_getCandidates);
  }

  Future<void> _getCandidates(
      GetCandidates event, Emitter<DashboardState> emit) async {
    try {
      emit(CandidateListLoadingState());
      CandidateModel successResponse = await dashboardNetwork.fetchCandidates(
          candidateRequest: event.candidateRequest);

      emit(CandidateListLoadedState(candidates: successResponse.data ?? []));
    } catch (e) {
      emit(CandidateLisFailedState());
    }
  }
}
