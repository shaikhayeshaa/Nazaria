import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewAllPosts extends StatefulWidget {
  const ViewAllPosts({super.key});

  @override
  State<ViewAllPosts> createState() => _ViewAllPostsState();
}

class _ViewAllPostsState extends State<ViewAllPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts',
            style: GoogleFonts.poppins(
                fontSize: 18.sp, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Consumer<CollPostViewModel>(builder: (context, ref, child) {
        if (ref.posts.isEmpty) {
          return Center(
              child: CircularProgressIndicator(
            strokeWidth: 6.sp,
          ));
        }
        return Padding(
          padding: EdgeInsets.all(2.w),
          child: GridView.builder(
            padding: EdgeInsets.all(2.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 2.w,
            ),
            itemCount: ref.posts.length,
            itemBuilder: (context, index) {
              final post = ref.posts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.view_post,
                      arguments: post);
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.grey, width: 1.w),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13.sp),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Image.network(
                            post.mediaUrl,
                            height: 30.h,
                            width: 60.w,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: 30.h,
                            width: 60.w,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   post.caption.toUpperCase(),
                                //   style: GoogleFonts.poppins(
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 15.sp,
                                //   ),
                                // ),
                                Text(
                                  'Created on: ${_formatDate(post.timestamp)}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          ),
        );
      }),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
