import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freequiz/2_profile/profile.dart';

import 'infos.dart';


Future<Map> httpGetLanguage() async {
  final response = await http.get(
    Uri.parse('${ApiInfos.basePath}/languages'),
    headers: {
      "Authorization": ApiInfos.bearerToken,
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