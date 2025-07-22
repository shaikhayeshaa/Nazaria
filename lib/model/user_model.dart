import 'package:nazaria/model/follow_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profileImageUrl;
  final String category;
  final String lives_in;
  final List<FollowInfo> followers;
  final List<FollowInfo> following;
  final int followersCount;
  final int followingCount;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.category,
    required this.lives_in,
    required this.followers,
    required this.following,
    required this.followersCount,
    required this.followingCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      category: json['category'],
      lives_in: json['lives_in'],
      followers: (json['followers'] as List)
          .map((f) => FollowInfo.fromJson(f))
          .toList(),
      following: (json['following'] as List)
          .map((f) => FollowInfo.fromJson(f))
          .toList(),
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'category': category,
      'lives_in': lives_in,
      'followers': followers.map((f) => f.toJson()).toList(),
      'following': following.map((f) => f.toJson()).toList(),
      'followersCount': followersCount,
      'followingCount': followingCount,
    };
  }
}
