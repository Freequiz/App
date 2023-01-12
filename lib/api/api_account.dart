import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:freequiz/2_profile/profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

bool newAccessToken = false;

//log in
Future<Map> httpPostSession(String username, String password) async {
  final response = await http.post(
    Uri.parse('https://freequiz.herokuapp.com/api/user/login'),
    headers: {
      "Authorization":
          "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
    },
    encoding: Encoding.getByName('utf-8'),
    body: {
      "username": username,
      "password": password,
    },
  );

  if (response.statusCode == 200) {
    newAccessToken = true;
    return jsonDecode(response.body);
  } else if (response.statusCode == 404) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error');
  }
}

//get account data
Future<Map> httpGetData() async {
  final response = await http.get(
    Uri.parse('https://freequiz.herokuapp.com/api/user/data'),
    headers: {
      "Authorization":
          "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
      "Access-token": Profile.accessToken
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    Profile.accessToken = "";
    Profile().deleteData();
    return jsonDecode(response.body);
  } else {
    throw Exception('Error');
  }
}

//get delete token to delete the account
Future<Map> httpGetDeleteToken() async {
  final response = await http.get(
    Uri.parse('https://freequiz.herokuapp.com/api/user/delete_token'),
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

//refresh access token
httpPostRefresh() async {
  if (!newAccessToken) {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final response = await http.post(
        Uri.parse('https://freequiz.herokuapp.com/api/user/refresh'),
        headers: {
          "Authorization":
              "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
          "Access-token": Profile.accessToken
        },
      );
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        Profile.accessToken = decodedResponse["access_token"];
        Profile().saveData();
        newAccessToken = true;
      } else if (response.statusCode == 401) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error');
      }
    }
  }
}

//change account information
Future<Map> httpPatchAccount(
    {String username = "",
    String email = "",
    String password = "",
    String passwordConfirmation = "",
    String oldPassword = ""}) async {
  final response = await http.patch(
      Uri.parse('https://freequiz.herokuapp.com/api/user/update'),
      headers: {
        "Authorization":
            "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
        "Access-token": Profile.accessToken,
        HttpHeaders.contentTypeHeader: "application/json"
      },
      encoding: Encoding.getByName('utf-8'),
      body: username != ""
          ? jsonEncode({
              "user": {"username": username}
            })
          : email != ""
              ? jsonEncode({
                  "user": {"email": email}
                })
              : jsonEncode({
                  "user": {
                    "password": password,
                    "password_confirmation": passwordConfirmation,
                    "old_password": oldPassword
                  }
                }));
  if (response.statusCode == 202) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 400) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error');
  }
}

//create account
Future<Map> httpPutAccount(String username, String email, String password,
    String passwordConfirmation, bool agb) async {
  final response = await http.put(
    Uri.parse('https://freequiz.herokuapp.com/api/user/create'),
    headers: {
      "Authorization":
          "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
      HttpHeaders.contentTypeHeader: "application/json"
    },
    encoding: Encoding.getByName('utf-8'),
    body: jsonEncode({
      "username": username,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "agb": agb
    }),
  );
  if (response.statusCode == 201) {
    newAccessToken = true;
    return jsonDecode(response.body);
  } else if (response.statusCode == 400) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error');
  }
}

//delete account
Future<Map> httpDeleteAccount(deleteToken) async {
  final response = await http.delete(
    Uri.parse('https://freequiz.herokuapp.com/api/user/delete/$deleteToken'),
    headers: {
      "Authorization":
          "Bearer 3b589393da6bc000705e75c9ae2fec24442fe09bad96b1f31645f9813abc1924",
      "Access-token": Profile.accessToken,
    },
  );
  if (response.statusCode == 200) {
    Profile.accessToken = "";
    Profile().deleteData();
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Error');
  }
}
