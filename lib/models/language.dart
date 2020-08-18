class Language {
  final String name;
  final String code;

  Language({this.code, this.name});

  static List<Language> getAllLanguages() {
    return <Language>[
      Language(name: "English", code: "en"),
      Language(name: "Gujarati", code: "gu"),
    ];
  }
}
