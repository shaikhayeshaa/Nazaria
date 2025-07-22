import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nazaria/model/user_model.dart';
import 'package:nazaria/repository/auth_repo.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/util/shared_prefs/shared_prefs.dart';
import 'package:nazaria/viewmodel/user_provider.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();
  bool isLoading = false;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String lives_in,
    required String category,
    required File profileImage,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final userCred = await _repo.signUp(email, password);
      final uid = userCred.user!.uid;

      final imageUrl = await _repo.uploadProfileImage(profileImage, uid);

      UserModel newUser = UserModel(
        uid: uid,
        name: name,
        email: email,
        profileImageUrl: imageUrl,
        category: category,
        lives_in: lives_in,
        followers: [], // 👈 Empty list of FollowInfo
        following: [], // 👈 Empty list of FollowInfo
        followersCount: 0,
        followingCount: 0,
      );

      await _repo.saveUserToFirestore(newUser);
      Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesName.signin,
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final userCred = await _repo.signIn(email, password);
      final uid = userCred.user!.uid;
      SharedPrefs.setString('uid', uid);
      final userSnap = await _repo.getUserProfile(uid);
      final userData = userSnap.data() as Map<String, dynamic>;
      final userModel = UserModel.fromJson(userData);
      SharedPrefs.setBool('isloggedIn', true);
      Provider.of<UserProvider>(context, listen: false).setUser(userModel);

      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.bottomNav, (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login error: ${e.toString()}")),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
