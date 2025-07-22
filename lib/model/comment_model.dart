import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentId;
  final String postId;
  final String userId;
  final String userName;
  final String userProfileUrl;
  final String text;
  final DateTime timestamp;

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userProfileUrl,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'postId': postId,
      'userId': userId,
      'userName': userName,
      'userProfileUrl': userProfileUrl,
      'text': text,
      'timestamp': timestamp,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'],
      postId: json['postId'],
      userId: json['userId'],
      userName: json['userName'],
      userProfileUrl: json['userProfileUrl'],
      text: json['text'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
}
