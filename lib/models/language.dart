class Language {
  int languageId;
  String languageName;

  Language({
    required this.languageId,
    required this.languageName,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      languageId: json['languageId'],
      languageName: json['languageName'],
    );
  }

  // Convert a Language object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'languageId': languageId,
      'languageName': languageName,
    };
  }

  @override
  String toString() {
    return languageName;
  }

  static List<Language> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Language.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Language> languages) {
    return languages.map((language) => language.toJson()).toList();
  }
}
