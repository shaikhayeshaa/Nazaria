import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nazaria/model/coll_model.dart';
import 'package:nazaria/model/comment_model.dart';
import 'package:nazaria/model/post_model.dart';
import 'package:nazaria/repository/collection_and_posts_repo.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:uuid/uuid.dart';

class CollPostViewModel with ChangeNotifier {
  final CollectionsAndPostsRepo _collPostRepo = CollectionsAndPostsRepo();
  bool isLoading = false;

  List<CollectionModel> _collections = [];
  List<CollectionModel> get collections => _collections;

  List<PostModel> _posts = [];
  List<PostModel> get posts => _posts;

  void setCollections(List<CollectionModel> collections) {
    _collections = collections;
    notifyListeners();
  }

  void setPosts(List<PostModel> posts) {
    _posts = posts;
    notifyListeners();
  }

  Future<void> fetchCollections() async {
    try {
      isLoading = true;
      _collections = [];
      notifyListeners();

      final data =
          await _collPostRepo.fetchCollections(); // 👈 implement this in repo
      setCollections(data);
    } catch (e) {
      print('Error fetching collections: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllPosts() async {
    try {
      isLoading = true;
      _posts = [];
      notifyListeners();

      final data = await _collPostRepo.fetchAllPosts();
      setPosts(data);
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserCollections(String userId) async {
    try {
      isLoading = true;
      _collections = [];
      notifyListeners();

      final data = await _collPostRepo.fetchUserCollections(userId);
      setCollections(data);
    } catch (e) {
      print('Error fetching collections: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostsByCollection(String collectionId) async {
    try {
      isLoading = true;
      _posts = [];
      notifyListeners();

      final data = await _collPostRepo.fetchPostsByCollection(collectionId);
      setPosts(data);
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllCollectionsByCategory(String category) async {
    try {
      isLoading = true;
      _collections = [];
      notifyListeners();

      final data = await _collPostRepo.fetchAllCollectionsByCategory(category);
      setCollections(data);
    } catch (e) {
      print('Error fetching collections: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserPosts(String userId) async {
    try {
      isLoading = true;
      _posts = [];
      notifyListeners();

      final data = await _collPostRepo.fetchUserPosts(userId);
      setPosts(data);
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNewCollection({
    required String userId,
    required String title,
    required String coverImageUrl,
    required String category,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final collectionId = const Uuid().v4();

      final firebaseImageUrl = await _collPostRepo.uploadProfileImage(
          File(coverImageUrl), collectionId);

      final newCollection = CollectionModel(
        collectionId: collectionId,
        userId: userId,
        title: title,
        coverImageUrl: firebaseImageUrl,
        category: category,
        createdAt: DateTime.now(),
      );

      await _collPostRepo.addNewCollection(newCollection);
      Navigator.pushReplacementNamed(context, RoutesName.bottomNav);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNewPost({
    required File mediaFile,
    required String userId,
    required String userName,
    required String userProfileUrl,
    required String caption,
    required String category,
    required String collectionId,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final postId = const Uuid().v4();

      final mediaUrl = await _collPostRepo.uploadPostMedia(mediaFile, postId);

      final newPost = PostModel(
        postId: postId,
        userId: userId,
        mediaUrl: mediaUrl,
        userProfileUrl: userProfileUrl,
        userName: userName,
        caption: caption,
        category: category,
        collectionId: collectionId,
        likes: [],
        commentsCount: 0,
        timestamp: DateTime.now(),
      );

      await _collPostRepo.addNewPost(newPost);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post uploaded successfully!")),
      );
      Navigator.pushReplacementNamed(context, RoutesName.bottomNav);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Post error: ${e.toString()}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<CommentModel> comments = [];

  Future<void> postComment({
    required String postId,
    required String userId,
    required String userName,
    required String userProfileUrl,
    required String text,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final commentId = const Uuid().v4();
      final comment = CommentModel(
        commentId: commentId,
        postId: postId,
        userId: userId,
        userName: userName,
        userProfileUrl: userProfileUrl,
        text: text,
        timestamp: DateTime.now(),
      );

      await _collPostRepo.addComment(comment);
      comments.insert(0, comment);
    } catch (e) {
      debugPrint("🔥 Error posting comment: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getComments(String postId) async {
    try {
      isLoading = true;
      notifyListeners();

      comments = await _collPostRepo.fetchComments(postId);
    } catch (e) {
      debugPrint("🔥 Error fetching comments: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearComments() {
    comments.clear();
    notifyListeners();
  }

  Future<void> togglelike(String postId, String userId) async {
    try {
      final postIndex = _posts.indexWhere((p) => p.postId == postId);
      if (postIndex == -1) return;

      final post = _posts[postIndex];
      final alreadyLiked = post.likes.contains(userId);

      if (alreadyLiked) {
        post.likes.remove(userId);
      } else {
        post.likes.add(userId);
      }

      notifyListeners();

      if (alreadyLiked) {
        await unLikePost(postId, userId);
      } else {
        await likePost(postId, userId);
      }
    } catch (e) {
      debugPrint("🔥 Error toggling like: $e");
    }
  }

  Future<void> likePost(String postId, String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      await _collPostRepo.likeAPost(postId, userId);
      final post = _posts.firstWhere((p) => p.postId == postId);
      if (!post.likes.contains(userId)) {
        post.likes.add(userId);
      }
    } catch (e) {
      debugPrint("🔥 Error liking post: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> unLikePost(String postId, String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      await _collPostRepo.unlikeAPost(postId, userId);
      final post = _posts.firstWhere((p) => p.postId == postId);
      if (post.likes.contains(userId)) {
        post.likes.remove(userId);
      }
    } catch (e) {
      debugPrint("🔥 Error unliking post: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
