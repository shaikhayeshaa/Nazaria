import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nazaria/model/user_model.dart';

class ViewUserRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UserModel> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return UserModel.fromJson(doc.data()!);
  }

  Future<List<UserModel>> fetchAllUsers() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }

  Future<void> followUser({
    required String currentUserId,
    required String currentUserName,
    required String currentUserImage,
    required String targetUserId,
    required String targetUserName,
    required String targetUserImage,
  }) async {
    final now = DateTime.now().toIso8601String();

    // Add currentUser to targetUser's followers
    await _firestore.collection('users').doc(targetUserId).update({
      'followers': FieldValue.arrayUnion([
        {
          'uid': currentUserId,
          'name': currentUserName,
          'image': currentUserImage,
          'followedAt': now,
        }
      ])
    });

    // Add targetUser to currentUser's following
    await _firestore.collection('users').doc(currentUserId).update({
      'following': FieldValue.arrayUnion([
        {
          'uid': targetUserId,
          'name': targetUserName,
          'image': targetUserImage,
          'followedAt': now,
        }
      ])
    });
  }

  Future<void> unfollowUser({
    required String currentUserId,
    required String targetUserId,
  }) async {
    final currentUserDoc =
        await _firestore.collection('users').doc(currentUserId).get();
    final targetUserDoc =
        await _firestore.collection('users').doc(targetUserId).get();

    final currentFollowing =
        List<Map<String, dynamic>>.from(currentUserDoc['following']);
    final targetFollowers =
        List<Map<String, dynamic>>.from(targetUserDoc['followers']);

    currentFollowing.removeWhere((user) => user['uid'] == targetUserId);
    targetFollowers.removeWhere((user) => user['uid'] == currentUserId);

    await _firestore.collection('users').doc(currentUserId).update({
      'following': currentFollowing,
    });

    await _firestore.collection('users').doc(targetUserId).update({
      'followers': targetFollowers,
    });
  }

  Future<bool> checkFollowStatus(
      String currentUserId, String targetUserId) async {
    final currentUserDoc =
        await _firestore.collection('users').doc(currentUserId).get();
    final targetUserDoc =
        await _firestore.collection('users').doc(targetUserId).get();

    final currentFollowing =
        List<Map<String, dynamic>>.from(currentUserDoc['following']);
    final targetFollowers =
        List<Map<String, dynamic>>.from(targetUserDoc['followers']);

    return currentFollowing.any((user) => user['uid'] == targetUserId) &&
        targetFollowers.any((user) => user['uid'] == currentUserId);
  }
}
