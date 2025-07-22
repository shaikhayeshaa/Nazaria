import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewAllCollections extends StatefulWidget {
  const ViewAllCollections({super.key});

  @override
  State<ViewAllCollections> createState() => _ViewAllCollectionsState();
}

class _ViewAllCollectionsState extends State<ViewAllCollections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collections',
            style: GoogleFonts.poppins(
                fontSize: 18.sp, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Consumer<CollPostViewModel>(builder: (context, ref, child) {
        if (ref.collections.isEmpty) {
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
            itemCount: ref.collections.length,
            itemBuilder: (context, index) {
              final collection = ref.collections[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, RoutesName.view_posts_by_collection,
                      arguments: collection);
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.grey, width: 1),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.sp),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Image.network(
                            ref.collections[index].coverImageUrl,
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
                                Text(
                                  ref.collections[index].title.toUpperCase(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                Text(
                                  'Created on: ${_formatDate(collection.createdAt)}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withOpacity(0.8),
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
