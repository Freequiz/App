import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freequiz/2_profile/profile.dart';
import 'package:http/http.dart';

class Api {
  static const basePath = "https://dev.freequiz.ch/api/";

  static Map defaultResponse = {"success": false};

  static Uri uri(String path) {
    return Uri.parse(basePath + path);
  }

  static Future<Response> httpPut(
      {required String path, required Object body}) async {
    return put(
      uri(path),
      headers: {
        "Authorization": Profile.accessToken,
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
        "Authorization": Profile.accessToken
      },
    );
  }

  static Future<Response> httpDelete({required String path}) async {
    return delete(
      uri(path),
      headers: {
        "Authorization": Profile.accessToken
      },
    );
  }

  static Future<Response> httpPost({required String path}) async {
    return post(uri(path), headers: {
      "Authorization": Profile.accessToken
    });
  }

  static Future<Response> httpPatch(
      {required String path, required Object body}) async {
    return patch(
      uri(path),
      headers: {
        "Authorization": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(body),
    );
  }

  static Map decodeResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 201:
        return jsonDecode(response.body);
      case 202:
        return jsonDecode(response.body);
      case 400:
        printError(response);
        return jsonDecode(response.body);
      case 401:
        printError(response);
        return jsonDecode(response.body);
      case 404:
        printError(response);
        return jsonDecode(response.body);
      case 503:
        printError(response);
        return defaultResponse;
      default:
        throw Exception('Unhandled Error');
    }
  }

  static void printError(Response response) async {
    debugPrint((await jsonDecode(response.body)).toString());
  }
}
