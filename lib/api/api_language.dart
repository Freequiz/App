import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freequiz/2_profile/profile.dart';

Future<Map> httpGetLanguage() async {
  final response = await http.get(
    Uri.parse('https://freequiz.herokuapp.com/api/languages'),
    headers: {
      "Authorization":
          "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
      "Access-token": Profile.accessToken
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error');
  }
}