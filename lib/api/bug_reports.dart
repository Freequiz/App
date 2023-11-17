import 'dart:convert';
import 'dart:io';
import 'package:freequiz/2_profile/profile.dart';
import 'package:http/http.dart' as http;
import 'infos.dart';

Future<Map> httpPutBug(
    String title, String description, String platform, String userAgent) async {
  final response = await http.put(
    Uri.parse('${ApiInfos.basePath}/bug/create'),
    headers: {
      "Authorization": ApiInfos.bearerToken,
      "Access-token": Profile.accessToken,
      HttpHeaders.contentTypeHeader: "application/json"
    },
    encoding: Encoding.getByName('utf-8'),
    body: jsonEncode({
      "title": title,
      "body": description,
      "platform": platform,
      "user_agent": userAgent
    }),
  );
  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 400) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error');
  }
}
