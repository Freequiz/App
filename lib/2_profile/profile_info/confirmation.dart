import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/api/users.dart';
import 'package:freequiz/utilities/extensions/context_extensions.dart';

class Confirmation extends StatelessWidget {
  final Function refresh;
  const Confirmation({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.tr('delete account'),
        style: TextStyle(color: context.darkMode ? Colors.white : Colors.black),
      ),
      content: const Text('delete account confirmation').tr(),
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
                        context.tr('delete account'),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('close').tr(),
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
