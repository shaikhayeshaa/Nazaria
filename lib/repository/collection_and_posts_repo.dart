import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nazaria/model/coll_model.dart';
import 'package:nazaria/model/comment_model.dart';
import 'package:nazaria/model/post_model.dart';

class CollectionsAndPostsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addNewCollection(CollectionModel collection) async {
    await _firestore
        .collection('collections')
        .doc(collection.collectionId)
        .set(collection.toJson());
  }

  Future<String> uploadProfileImage(File file, String collectionId) async {
    final ref = _storage.ref().child("collectionImages/$collectionId.jpg");
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<String> uploadPostMedia(File mediaFile, String postId) async {
    final ref = _storage.ref().child('postMedia/$postId');
    await ref.putFile(mediaFile);
    return await ref.getDownloadURL();
  }

  Future<void> addNewPost(PostModel post) async {
    await _firestore.collection('posts').doc(post.postId).set(post.toJson());
  }

  Future<List<CollectionModel>> fetchCollections() async {
    final snapshot = await _firestore.collection('collections').get();

    return snapshot.docs
        .map((doc) => CollectionModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<CollectionModel>> fetchUserCollections(String userId) async {
    final snapshot = await _firestore
        .collection('collections')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => CollectionModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<PostModel>> fetchAllPosts() async {
    final snapshot = await _firestore.collection('posts').get();

    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }

  Future<List<PostModel>> fetchUserPosts(String userId) async {
    final snapshot = await _firestore
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }

  Future<List<PostModel>> fetchPostsByCollectionId(String collectionId) async {
    final snapshot = await _firestore
        .collection('posts')
        .where('collectionId', isEqualTo: collectionId)
        .get();

    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }

  Future<List<CollectionModel>> fetchUserCategories(String userId) async {
    final snapshot = await _firestore
        .collection('collections')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => CollectionModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<PostModel>> fetchPostsByCollection(String collectionId) async {
    final snapshot = await _firestore
        .collection('posts')
        .where('collectionId', isEqualTo: collectionId)
        .get();

    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }

  Future<void> addComment(CommentModel comment) async {
    await _firestore
        .collection('posts')
        .doc(comment.postId)
        .collection('comments')
        .doc(comment.commentId)
        .set(comment.toJson());

    await _firestore.collection('posts').doc(comment.postId).update({
      'commentsCount': FieldValue.increment(1),
    });
  }

  Future<List<CommentModel>> fetchComments(String postId) async {
    final snapshot = await _firestore
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => CommentModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> likeAPost(String postId, String userId) async {
    final postRef = _firestore.collection('posts').doc(postId);

    await postRef.update({
      'likes': FieldValue.arrayUnion([userId]),
    });
  }

  Future<void> unlikeAPost(String postId, String userId) async {
    final postRef = _firestore.collection('posts').doc(postId);

    await postRef.update({
      'likes': FieldValue.arrayRemove([userId]),
    });
  }

  Future<List<CollectionModel>> fetchAllCollectionsByCategory(
      String category) async {
    final snapshot = await _firestore
        .collection('collections')
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs
        .map((doc) => CollectionModel.fromJson(doc.data()))
        .toList();
  }
}
