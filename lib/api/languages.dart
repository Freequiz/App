import 'dart:convert';
import 'api.dart';


Future<Map> httpGetLanguage() async {
  final response = await Api.httpGet(path: 'languages');

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error');
  }
}