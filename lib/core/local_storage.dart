import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStoragePref {
  static LocalStoragePref? _instance;
  static FlutterSecureStorage? storage;

  static LocalStoragePref? get instance {
    _instance ??= LocalStoragePref();

    return _instance;
  }

  Future initPrefBox() async {
    storage ??= const FlutterSecureStorage();
  }

  Future<void>? setIsLogin() {
    return storage?.write(key: LocalStorageKeys.isLogin, value: 'true');
  }

  Future<String> isLogin() async {
    return await storage?.read(key: LocalStorageKeys.isLogin) ?? 'false';
  }

  Future clearAllPref() async {
    await storage?.deleteAll();
  }
}

class LocalStorageKeys {
  static String isLogin = 'is_login';
}
