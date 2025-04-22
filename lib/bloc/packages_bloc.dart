import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/bloc/packages_events.dart';
import 'package:kaamwalijobs_new/bloc/packages_state.dart';
import 'package:kaamwalijobs_new/models/packages_model.dart';

class PackagesBloc extends Bloc<GetPackagesEvent, PackagesState> {
  PackagesBloc() : super(PackagesInitialState()) {
    on<GetPackagesEvent>(_getMenuPackages);
  }

  void _getMenuPackages(
      GetPackagesEvent event, Emitter<PackagesState> emit) async {
    try {
      PackagesModel candidatePackagesModel = await Repositiory().getPackages();

      emit(PackagesLoadedState(candidatePackagesModel: candidatePackagesModel));
    } on Exception catch (e) {
      (e.toString());
    }
  }
}
