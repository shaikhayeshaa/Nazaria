import 'package:flutter/material.dart';
import 'package:nazaria/model/user_model.dart';
import 'package:nazaria/repository/view_user_repo.dart';
import 'package:nazaria/viewmodel/user_provider.dart';
import 'package:provider/provider.dart';

class ViewUserViewModel extends ChangeNotifier {
  final ViewUserRepo _repo = ViewUserRepo();

  UserModel? _viewedUser;
  UserModel? get viewedUser => _viewedUser;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;

  void setUsers(List<UserModel> users) {
    _users = users;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void checkIfFollowing(String currentUserId) {
    if (_viewedUser == null) return;

    final isFollowed =
        _viewedUser!.followers.any((follower) => follower.uid == currentUserId);
    _isFollowing = isFollowed;
    notifyListeners();
  }

  Future<void> fetchUserProfile(String uid, {String? currentUserId}) async {
    _isLoading = true;
    _viewedUser = null;
    notifyListeners();

    try {
      final user = await _repo.getUserProfile(uid);
      _viewedUser = user;

      // Check follow state if current user id is provided
      if (currentUserId != null) {
        checkIfFollowing(currentUserId);
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchOwnProfile(BuildContext context, String uid) async {
    _isLoading = true;
    _viewedUser = null;
    notifyListeners();

    try {
      final user = await _repo.getUserProfile(uid);
      _viewedUser = user;
      Provider.of<UserProvider>(context, listen: false).setUser(user);
    } catch (e) {
      print("Error fetching own profile: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllUsers() async {
    try {
      _isLoading = true;
      notifyListeners();

      final data = await _repo.fetchAllUsers();
      setUsers(data);
    } catch (e) {
      print('Error fetching users: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> followUser({
    required String currentUserId,
    required String currentUserName,
    required String currentUserImage,
    required String targetUserId,
    required String targetUserName,
    required String targetUserImage,
  }) async {
    setLoading(true);

    try {
      await _repo.followUser(
        currentUserId: currentUserId,
        currentUserName: currentUserName,
        currentUserImage: currentUserImage,
        targetUserId: targetUserId,
        targetUserName: targetUserName,
        targetUserImage: targetUserImage,
      );
      _isFollowing = true;

      // Refresh viewed user profile
      await fetchUserProfile(targetUserId);
    } catch (e) {
      print("Error while following: $e");
    }

    setLoading(false);
  }

  Future<void> unfollowUser({
    required String currentUserId,
    required String targetUserId,
  }) async {
    setLoading(true);

    try {
      await _repo.unfollowUser(
        currentUserId: currentUserId,
        targetUserId: targetUserId,
      );
      _isFollowing = false;

      await fetchUserProfile(targetUserId);
    } catch (e) {
      print("Error while unfollowing: $e");
    }

    setLoading(false);
  }

  void togglefollow() {
    _isFollowing = !_isFollowing;
    notifyListeners();
  }

  void setIsFollowing(bool value) {
    _isFollowing = value;
    notifyListeners();
  }
}
