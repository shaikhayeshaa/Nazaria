import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionModel {
  final String collectionId;
  final String userId;
  final String title;
  final String coverImageUrl;
  final String category;
  final DateTime createdAt;

  CollectionModel({
    required this.collectionId,
    required this.userId,
    required this.title,
    required this.coverImageUrl,
    required this.category,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'userId': userId,
      'title': title,
      'coverImageUrl': coverImageUrl,
      'category': category,
      'createdAt': createdAt,
    };
  }

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      collectionId: json['collectionId'],
      userId: json['userId'],
      title: json['title'],
      coverImageUrl: json['coverImageUrl'],
      category: json['category'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}
