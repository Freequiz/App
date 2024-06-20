class Language {
  Map language;

  String id;
  String name;
  String locale;

  Language({
    required this.language,
    required this.id,
    required this.name,
    required this.locale,
  });

  factory Language.fromJson(Map language) {
    return switch (language) {
      {
        "id": String id,
        "name": String name,
        "locale": String locale,
      } =>
        Language(
          language: language,
          id: id,
          name: name,
          locale: locale,
        ),
      _ => throw const FormatException("Failed to load Translations."),
    };
  }

  toMap() {
    return {
      'id': id,
      'name': name,
      'locale': locale
    };
  }
}
