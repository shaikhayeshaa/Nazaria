import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectCategoury extends StatefulWidget {
  const SelectCategoury({super.key});

  @override
  State<SelectCategoury> createState() => _SelectCategouryState();
}

class _SelectCategouryState extends State<SelectCategoury> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/darkbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Text(
              'Select Category',
              textAlign: TextAlign.center,
              style: GoogleFonts.akronim(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: GridView(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 2.h,
                  childAspectRatio: 1,
                ),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signup,
                          arguments: 'illustrator');
                    },
                    child: Image(
                        image: AssetImage('assets/illustrator.png'),
                        fit: BoxFit.fill),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signup,
                          arguments: 'photographer');
                    },
                    child: Image(
                      image: AssetImage(
                        'assets/photographer.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signup,
                          arguments: 'video_editor');
                    },
                    child: Image(
                      image: AssetImage('assets/videoediting.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signup,
                          arguments: 'designer');
                    },
                    child: Image(
                      image: AssetImage('assets/designer.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
