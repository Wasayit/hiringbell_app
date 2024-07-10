class Religion {
  int religionId;
  String religionName;

  Religion({
    required this.religionId,
    required this.religionName,
  });

  factory Religion.fromJson(Map<String, dynamic> json) {
    return Religion(
      religionId: json['religionId'],
      religionName: json['religionName'],
    );
  }

  // Convert a Religion object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'religionId': religionId,
      'religionName': religionName,
    };
  }

  @override
  String toString() {
    return religionName;
  }

  static List<Religion> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Religion.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Religion> religions) {
    return religions.map((religion) => religion.toJson()).toList();
  }
}
