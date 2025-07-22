import 'package:flutter/material.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/view/add/add_new_collection.dart';
import 'package:nazaria/view/add/add_new_post.dart';
import 'package:nazaria/view/auth/boarding.dart';
import 'package:nazaria/view/auth/select_categoury.dart';
import 'package:nazaria/view/auth/signin.dart';
import 'package:nazaria/view/auth/signup.dart';
import 'package:nazaria/view/auth/splash/splash.dart';
import 'package:nazaria/view/bottomnav.dart/bottom_nav.dart';
import 'package:nazaria/view/categouries/view_all_Posts.dart';
import 'package:nazaria/view/categouries/view_all_collections.dart';
import 'package:nazaria/view/home/view_post.dart';
import 'package:nazaria/view/profile/settings.dart';
import 'package:nazaria/view/profile/view_posts_by_collection.dart';
import 'package:nazaria/view/profile/view_user_profile.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => Splash());
      case RoutesName.boarding:
        return MaterialPageRoute(builder: (context) => Boarding());
      case RoutesName.signin:
        return MaterialPageRoute(builder: (context) => Signin());
      case RoutesName.selectCategory:
        return MaterialPageRoute(builder: (context) => SelectCategoury());
      case RoutesName.bottomNav:
        return MaterialPageRoute(builder: (context) => BottomNav());
      case RoutesName.viewAllCollections:
        return MaterialPageRoute(
            builder: (context) => ViewAllCollections(), settings: settings);
      case RoutesName.viewAllPosts:
        return MaterialPageRoute(
            builder: (context) => ViewAllPosts(), settings: settings);
      case RoutesName.setting:
        return MaterialPageRoute(builder: (context) => Settings());

      case RoutesName.addNewCollection:
        return MaterialPageRoute(builder: (context) => AddCollectionScreen());
      case RoutesName.addNewPost:
        return MaterialPageRoute(builder: (context) => AddPostScreen());
      case RoutesName.viewuserprofile:
        return MaterialPageRoute(
            builder: (context) => ViewUserProfile(), settings: settings);

      case RoutesName.view_post:
        return MaterialPageRoute(
            builder: (context) => ViewPost(), settings: settings);
      case RoutesName.view_posts_by_collection:
        return MaterialPageRoute(
            builder: (context) => ViewPostsByCollection(), settings: settings);

      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (context) => Signup(), settings: settings);

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('No route find'),
            ),
          );
        });
    }
  }
}
