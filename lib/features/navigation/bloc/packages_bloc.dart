import 'package:bloc/bloc.dart';

import '../../../Client/homepage_api.dart';
import '../../../Client/menupage_api.dart';
import '../../../core/local_storage.dart';
import '../../../models/current_package_plan.dart';
import '../../../models/sortlisted_candidate_model.dart';
import 'packages.state.dart';
import 'packages_event.dart';

class PurchasedPackageDataBloc extends Bloc<PackageEvent, PackageState> {
  PurchasedPackageDataBloc() : super(PackageIntitialState()) {
    on<PurchasedPackageEvent>(_getPackagesData);
    // on<PurchasedPackageJobEvent>(_getJobsPackagesData);
    on<SortListedCandidateEvent>(_getSortListedCandidate);
  }

  Future<void> _getPackagesData(
      PackageEvent event, Emitter<PackageState> emit) async {
    try {
      LocalStoragePref localStoragePref = LocalStoragePref();
      String userId = localStoragePref.getUserProfile()!.userId;
      CurrentPackagePlan currentPackagePlan =
          await Repositiory().getCurrentPackages(userId);
      emit(PackageLoadedStates(currentPackagePlan: currentPackagePlan));
    } catch (e) {
      emit(PackageFailedState(
          errorMsg: "Unable to Load Data. Please try again later"));
      print("Error: $e");
    }
  }

  // Future<void> _getJobsPackagesData(
  //     PackageEvent event, Emitter<PackageState> emit) async {
  //   try {
  //     LocalStoragePref localStoragePref = LocalStoragePref();
  //     String userId = localStoragePref.getUserProfile()!.userId;
  //     PurchasedpackagesJob currentjobsPackagePlan =
  //         await Repositiory().getCurrentJobPackages(userId);
  //     emit(CurrentJobsPackageLoadedState(
  //         purchasedpackagesJob: currentjobsPackagePlan));
  //   } catch (e) {
  //     emit(CurrentJobsPackageFailedState(
  //         errorMsg: "Unable to Load Data. Please try again later"));
  //     print("Error: $e");
  //   }
  // }

  Future<void> _getSortListedCandidate(
      SortListedCandidateEvent event, Emitter<PackageState> emit) async {
    try {
      LocalStoragePref localStoragePref = LocalStoragePref();
      String userId = localStoragePref.getUserProfile()!.userId;
      String flag = localStoragePref.getUserProfile()!.flag;
      Shortlistedcandidatemodel sortListedCandidate = await MenuPageRepository()
          .getSortListedCandidate(
              event.sortType, event.candidateId, flag, userId);
      emit(SortListedCandidateLoadedState(
          sortListedCandidate: sortListedCandidate));
    } catch (e) {
      emit(SortListedCandidateFailedState(
          errorMsg: "Unable to Load Data. Please try again later"));
      print("Error: $e");
    }
  }
}
