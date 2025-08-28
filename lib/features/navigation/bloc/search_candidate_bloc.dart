import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/search_candidate_event.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/search_candidate_states.dart';

import '../../../models/search_candidate_model.dart';
import '../network/saerch_candidates_api.dart';

class SearchCandidateBloc
    extends Bloc<SearchCandidateEvent, SearchCandidateStates> {
  SearchCandidateBloc() : super(SearchCandidateInitialState()) {
    on<SearchCandidateLoadDataEvent>(_getSearchCanidateModel);
  }
  Future<void> _getSearchCanidateModel(SearchCandidateLoadDataEvent event,
      Emitter<SearchCandidateStates> emit) async {
    try {
      SearchCandidateModel _searchCandidateModel = await NavRepositiory()
          .getAvailableCandidates(candidateRequest: event.candidateRequest);
      emit(SearchCandidateSuccessState(candidates: _searchCandidateModel.data));
      emit(SearchCandidateCountLoaded(
          candidatecount: _searchCandidateModel.candidateCount));
      if (_searchCandidateModel.data == []) {
        emit(SearchCandidateErrorState(errorMsg: "No candidate available."));
      }
    } catch (e) {
      emit(SearchCandidateErrorState(
          errorMsg: "Unable to fetch candidates. Please try again later."));
      print("Error: $e");
    }
  }
}
