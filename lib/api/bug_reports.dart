import 'dart:convert';
import 'api.dart';

Future<Map> httpPutBug(
    String title, String description, String platform, String userAgent) async {
  final response = await Api.httpPut(
    path: 'bug/create',
    body: jsonEncode({
      "title": title,
      "body": description,
      "platform": platform,
      "user_agent": userAgent
    }),
  );

  return Api.decodeResponse(response);
}
