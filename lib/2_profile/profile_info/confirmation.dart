import 'package:flutter/material.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/others/device_info.dart';
import 'package:freequiz/others/initial_loading.dart';

class Confirmation extends StatelessWidget {
  final Function refresh;
  const Confirmation({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        language["Delete Account"],
        style: TextStyle(color: DeviceInfo.darkMode ? Colors.white : Colors.black),
      ),
      content: Text(language[
          "Are you sure you want to delete your account. It's not reversible"]),
      actions: [
        FutureBuilder<Map>(
          future: APIUsers.getDeleteToken(),
          builder: (context, data) {
            if (data.hasData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await APIUsers.deleteAccount(data.data!["token"]);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        refresh();
                      },
                      child: Text(
                        language["Delete Account"],
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(language["Close"]),
                    )
                  ],
                ),
              );
            } else if (data.hasError) {
              return Text('${data.error}');
            } else {
              return const Center(child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: CircularProgressIndicator(),
              ));
            }
          },
        ),
      ],
    );
  }
}
