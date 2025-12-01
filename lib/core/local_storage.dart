import 'dart:convert';

import 'package:kaamwalijobs_new/models/employer_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/current_package_plan.dart';

class LocalStoragePref {
  static LocalStoragePref? _instance;
  static SharedPreferences? storage;

  static LocalStoragePref? get instance {
    _instance ??= LocalStoragePref();

    return _instance;
  }

  Future initPrefBox() async {
    storage ??= await SharedPreferences.getInstance();
  }

  void storeUserProfile(String userProfileData) async {
    await storage!.setString(LocalStorageKeys.userProfile, userProfileData);
  }

  // void storeCandidateProfile(String userProfileData) async {
  //   await storage!
  //       .setString(LocalStorageKeys.storeCandidateProfile, userProfileData);
  // }

  EmployerRegisterModel? getUserProfile() {
    String? response = storage?.getString(LocalStorageKeys.userProfile);
    if (response != null) {
      EmployerRegisterModel employerRegisterModel =
          EmployerRegisterModel.fromJson(jsonDecode(response));
      return employerRegisterModel;
    }
    return null;
  }

  Future<void> temproraryAccDelete() async {
    await storage?.setBool(LocalStorageKeys.accDelete, true);
  }

  bool? gettemproraryAccDelete() {
    return storage?.getBool(LocalStorageKeys.accDelete);
  }

  CurrentPackagePlan? currentPackageData() {
    String? response = storage?.getString(LocalStorageKeys.currentPackageData);
    if (response != null) {
      CurrentPackagePlan currentPackagePlan =
          CurrentPackagePlan.fromJson(jsonDecode(response));
      return currentPackagePlan;
    }
    return null;
  }

  void storeCurrentPackage(String currentPackage) async {
    await storage!
        .setString(LocalStorageKeys.currentPackageData, currentPackage);
  }

  // EmployerRegisterModel? getCandidateProfile() {
  //   String? response =
  //       storage?.getString(LocalStorageKeys.storeCandidateProfile);
  //   if (response != null) {
  //     EmployerRegisterModel candidateRegisterModel =
  //         EmployerRegisterModel.fromJson(jsonDecode(response));
  //     return candidateRegisterModel;
  //   }
  //   return null;
  // }

  Future clearAllPref() async {
    await storage?.clear();
  }
}

class LocalStorageKeys {
  static String userProfile = 'user_profile';
  static String currentPackageData = 'current_package_data';
  static const accDelete = 'token';
  // static String storeCandidateProfile = 'candidate_user_profile';
}
