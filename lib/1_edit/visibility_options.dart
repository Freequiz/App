import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freequiz/others/string_extensions.dart';

class VisibilityOptions {
  static List<DropdownMenuItem<String>> visibilites = [
    DropdownMenuItem(
          value: "public",
          child: Text("public".toString().tr().capitalize()),
        ),
        DropdownMenuItem(
          value: "hidden",
          child: Text("hidden".toString().tr().capitalize()),
        ),
        DropdownMenuItem(
          value: "private",
          child: Text("private".toString().tr().capitalize()),
        ),
  ];

  static Map<String, IconData> icons = {
    "public": Icons.public,
    "private": Icons.lock_outline,
    "hidden": Icons.hide_source_rounded
  };
}