import 'package:hiringbell/models/constants.dart';

class UserDocument {
  final int docId;
  final int userId;
  String? docName;
  String? docPath;

  UserDocument({
    this.docId = 0,
    this.userId = 0,
    this.docName = Constants.empty,
    this.docPath = Constants.empty,
  });

  factory UserDocument.fromJson(Map<String, dynamic> json) {
    return UserDocument(
      docId: json['docId'],
      userId: json['userId'],
      docName: json['docName'] ?? Constants.empty,
      docPath: json['docPath'] ?? Constants.empty,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'userId': userId,
      'docName': docName,
      'docPath': docPath,
    };
  }

  static List<UserDocument> fromJsonList(List<dynamic>? jsonList) {
    return (jsonList ?? []).map((json) => UserDocument.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(
      List<UserDocument> userdocuments) {
    return userdocuments.map((userdocument) => userdocument.toJson()).toList();
  }
}
