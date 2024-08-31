import 'api.dart';


Future<Map> httpGetLanguage() async {
  final response = await Api.httpGet(path: 'languages');

  return Api.decodeResponse(response);
}