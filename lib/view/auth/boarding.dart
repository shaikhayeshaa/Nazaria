import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Boarding extends StatefulWidget {
  const Boarding({super.key});

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
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
              top: 10.h,
              child: Text('Nazaria',
                  style: GoogleFonts.akronim(
                      fontSize: 30.sp, color: MyColors.white))),
          Positioned(
              top: 20.h, child: Image(image: AssetImage('assets/splash.png'))),
          Positioned(
            bottom: 20.h,
            child: Text(
              'Welcome to Nazaria',
              style: GoogleFonts.akronim(
                color: MyColors.white,
                fontSize: 20.sp,
              ),
            ),
          ),
          Positioned(
            bottom: 10.h,
            child: SizedBox(
              width: 60.w,
              height: 7.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.signin);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.lessOpacitywhite,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.poppins(
                    color: MyColors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
