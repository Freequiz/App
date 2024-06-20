import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const storage = FlutterSecureStorage();

  static setAccessToken(String accessToken) async {
    await storage.write(key: "access_token", value: accessToken);
  }

  static Future<String> readAccessToken() async {
    String accessToken = await storage.read(key: "access_token") ?? "";
    return accessToken;
  }

  static removeAccessToken() async {
    await storage.delete(key: "access_token");
  }
}