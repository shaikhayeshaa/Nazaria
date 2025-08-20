import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/util/shared_prefs/shared_prefs.dart';
import 'package:nazaria/viewmodel/view_user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> init() async {
    final uid = SharedPrefs.getString('uid');
    final islog = SharedPrefs.getBool('isloggedIn');

    if (islog == null || islog == false || uid == null) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, RoutesName.signin);
    } else {
      await Provider.of<ViewUserViewModel>(context, listen: false)
          .fetchOwnProfile(context, uid);
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, RoutesName.bottomNav);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/darkbg.png'), fit: BoxFit.cover)),
          ),
          Positioned(
              top: 15.h,
              child: Text('Nazaria',
                  style: GoogleFonts.akronim(
                      fontSize: 30.sp, color: MyColors.white))),
          Positioned(
              top: 25.h, child: Image(image: AssetImage('assets/splash.png')))
        ],
      ),
    );
  }
}
