import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainButton extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback onTap;
  const MainButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 6.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: MyColors.purple, borderRadius: BorderRadius.circular(30)),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    )
                  : Text(title,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold
                            fontFamily: 'Poppins'),
                      )))),
    );
  }
}
