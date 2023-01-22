import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freequiz/2_profile/profile.dart';

const domain = 'https://freequiz.herokuapp.com';
const bearerToken = 'Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924';

Future<Map> httpGetLanguage() async {
  final response = await http.get(
    Uri.parse('$domain/api/languages'),
    headers: {
      "Authorization":
          bearerToken,
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