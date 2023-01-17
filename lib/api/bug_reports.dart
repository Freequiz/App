import 'dart:convert';
import 'dart:io';
import 'package:freequiz/2_profile/profile.dart';
import 'package:http/http.dart' as http;

Future<Map> httpPutBug(String title, String description, String platform, String userAgent) async {
 final response = await http.put(
    Uri.parse('https://freequiz.herokuapp.com/api/bug/create'),
    headers: {
      "Authorization":
          "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
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