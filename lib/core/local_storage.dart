import 'dart:convert';

import 'package:kaamwalijobs_new/models/employer_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  EmployerRegisterModel? getUserProfile() {
    String? response = storage?.getString(LocalStorageKeys.userProfile);
    if (response != null) {
      EmployerRegisterModel employerRegisterModel =
          EmployerRegisterModel.fromJson(jsonDecode(response));
      return employerRegisterModel;
    }
    return null;
  }

  Future clearAllPref() async {
    await storage?.clear();
  }
}

class LocalStorageKeys {
  static String userProfile = 'user_profile';
}
