import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:freequiz/_views/profile/profile.dart';
import 'package:http/http.dart';

class Api {
  static const basePath = kReleaseMode ? "https://www.freequiz.ch/api/" : "https://test.freequiz.ch/api/";

  static String noConnection = 'no connection';
  static String timeout = 'request timed out';

  static Map responseDefault = {'success': false};
  static Map responseNoConnection = {"success": false, "message": noConnection};
  static Map responseTimeout = {"success": false, "message": timeout};

  static Uri uri(String path) {
    return Uri.parse(basePath + path);
  }

  static Future<Response> requestHandler({required Function request}) async {
    try {
      final Response response = await request();
      return response;
    } on TimeoutException catch (_) {
      return Response(jsonEncode(responseTimeout), 503);
    } on SocketException catch (_) {
      return Response(jsonEncode(responseNoConnection), 503);
    } catch (e) {
      responseDefault['message'] = e;
      return Response(jsonEncode(responseDefault), 500);
    }
  }

  static Future<Response> httpPut({required String path, required Object body}) async {
    return requestHandler(
      request: () {
        return put(
          uri(path),
          headers: {"Authorization": Profile.accessToken, HttpHeaders.contentTypeHeader: "application/json"},
          encoding: Encoding.getByName('utf-8'),
          body: json.encode(body),
        ).timeout(const Duration(seconds: 10));
      },
    );
  }

  static Future<Response> httpGet({required String path}) async {
    return requestHandler(
      request: () {
        return get(
          uri(path),
          headers: {"Authorization": Profile.accessToken},
        ).timeout(const Duration(seconds: 5));
      },
    );
  }

  static Future<Response> httpDelete({required String path}) async {
    return requestHandler(
      request: () {
        return delete(
          uri(path),
          headers: {"Authorization": Profile.accessToken},
        ).timeout(const Duration(seconds: 10));
      },
    );
  }

  static Future<Response> httpPost({required String path, required Object body}) async {
    return requestHandler(
      request: () {
        return post(
          uri(path),
          headers: {"Authorization": Profile.accessToken, HttpHeaders.contentTypeHeader: "application/json"},
          encoding: Encoding.getByName('utf-8'),
          body: json.encode(body),
        ).timeout(const Duration(seconds: 5));
      },
    );
  }

  static Future<Response> httpPatch({required String path, required Object body}) async {
    return requestHandler(
      request: () {
        return patch(
          uri(path),
          headers: {"Authorization": Profile.accessToken, HttpHeaders.contentTypeHeader: "application/json"},
          encoding: Encoding.getByName('utf-8'),
          body: json.encode(body),
        ).timeout(const Duration(seconds: 10));
      },
    );
  }

  static Map decodeResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 400:
      case 401:
      case 404:
      case 500:
      case 503:
        try {
          return jsonDecode(response.body);
        }
        catch (_) {
          debugPrint("JSON couldn't be decoded");
          return responseDefault;
        }
      default:
        throw Exception('Unhandled Error');
    }
  }
}
