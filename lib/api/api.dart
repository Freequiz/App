import 'dart:convert';
import 'dart:io';
import 'package:freequiz/2_profile/profile.dart';
import 'package:freequiz/secrets.dart';
import 'package:http/http.dart';


class Api {
  static const basePath = "https://www.freequiz.ch/api/";

  static Uri uri(String path) {
    return Uri.parse(basePath + path);
  }

  static Future<Response> httpPut({required String path, required Object body}) async {
    return put(
      uri(path),
      headers: {
        "Authorization": Secrets.bearerToken,
        "Access-token": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
      body: body,
    );
  }

  static Future<Response> httpGet({required String path}) async {
    return get(
      uri(path),
      headers: {
        "Authorization": Secrets.bearerToken,
        "Access-token": Profile.accessToken
      },
    );
  }

  static Future<Response> httpDelete({required String path}) async {
    return delete(
      uri(path),
      headers: {
        "Authorization": Secrets.bearerToken,
        "Access-token": Profile.accessToken
      },
    );
  }

  static Future<Response> httpPost({required String path}) async {
    return post(
      uri(path),
      headers: {
        "Authorization": Secrets.bearerToken,
        "Access-token": Profile.accessToken
      }
    );
  }

  static Future<Response> httpPatch({required String path, required Object body}) async {
    return patch(
      uri(path),
      headers: {
        "Authorization": Secrets.bearerToken,
        "Access-token": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
      body: body,
    );
  }
}
