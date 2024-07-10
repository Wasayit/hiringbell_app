class Education {
  int educationId;
  String universityOrBoardName;
  int educationTypeId;
  String collageOrSchoolName;
  int yearOfPassout;
  int duration;
  String country;
  String? educationName;

  Education({
    required this.educationId,
    required this.educationTypeId,
    required this.universityOrBoardName,
    required this.collageOrSchoolName,
    required this.yearOfPassout,
    required this.duration,
    required this.country,
    this.educationName
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      educationId: json['educationId'],
      educationTypeId: json['educationTypeId'],
      universityOrBoardName: json['universityOrBoardName'],
      collageOrSchoolName: json['collageOrSchoolName'],
      yearOfPassout: json['yearOfPassout'],
      duration: json['duration'],
      country: json['country'],
      educationName: json['educationName']
    );
  }

  // Convert a Education object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'educationId': educationId,
      'educationTypeId': educationTypeId,
      'universityOrBoardName': universityOrBoardName,
      'collageOrSchoolName': collageOrSchoolName,
      'yearOfPassout': yearOfPassout,
      'duration': duration,
      'country': country,
      'educationName': educationName
    };
  }

  // @override
  // String toString() {
  //   return educationName;
  // }

  static List<Education> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Education.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Education> jobTypes) {
    return jobTypes.map((edu) => edu.toJson()).toList();
  }
}
