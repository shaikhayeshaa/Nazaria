import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String postId;
  final String userId;
  final String mediaUrl;
  final String userProfileUrl;
  final String userName;
  final String caption;
  final String category;
  final String collectionId;
  final List<String> likes;
  final int commentsCount;
  final DateTime timestamp;

  PostModel({
    required this.postId,
    required this.userId,
    required this.mediaUrl,
    required this.userProfileUrl,
    required this.userName,
    required this.caption,
    required this.category,
    required this.collectionId,
    required this.likes,
    required this.commentsCount,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'userId': userId,
      'mediaUrl': mediaUrl,
      'userProfileUrl': userProfileUrl,
      'userName': userName,
      'caption': caption,
      'category': category,
      'collectionId': collectionId,
      'likes': likes,
      'commentsCount': commentsCount,
      'timestamp': timestamp,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'],
      userId: json['userId'],
      mediaUrl: json['mediaUrl'],
      userProfileUrl: json['userProfileUrl'],
      userName: json['userName'],
      caption: json['caption'],
      category: json['category'],
      collectionId: json['collectionId'],
      likes: List<String>.from(json['likes']),
      commentsCount: json['commentsCount'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
}
