import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/resources/components/custom_clipper.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:nazaria/viewmodel/user_provider.dart';
import 'package:nazaria/viewmodel/view_user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewUserProfile extends StatefulWidget {
  const ViewUserProfile({super.key});

  @override
  State<ViewUserProfile> createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CollPostViewModel>(context, listen: false)
          .fetchUserCollections(
              ModalRoute.of(context)!.settings.arguments as String);
      Provider.of<CollPostViewModel>(context, listen: false)
          .fetchUserPosts(ModalRoute.of(context)!.settings.arguments as String);
      Provider.of<ViewUserViewModel>(context, listen: false).fetchUserProfile(
          ModalRoute.of(context)!.settings.arguments as String);
    });
  }

  @override
  Widget build(BuildContext context) {
    final collections = Provider.of<CollPostViewModel>(context).collections;
    final post = Provider.of<CollPostViewModel>(context).posts;
    final userid = ModalRoute.of(context)!.settings.arguments as String;
    final user = Provider.of<ViewUserViewModel>(context).viewedUser;
    final currentUser = Provider.of<UserProvider>(context).currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipPath(
                clipper: CurvedClipper(),
                child: Container(
                  height: 30.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/darkbg.png'),
                        fit: BoxFit.fitWidth),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              Positioned(
                top: 3.h,
                right: 4.w,
                child: Consumer<ViewUserViewModel>(
                  builder: (context, ref, child) {
                    return GestureDetector(
                      onTap: () async {
                        if (ref.isFollowing) {
                          await ref.unfollowUser(
                            currentUserId: currentUser.uid,
                            targetUserId: user!.uid,
                          );
                        } else {
                          await ref.followUser(
                            currentUserId: currentUser.uid,
                            currentUserName: currentUser.name,
                            currentUserImage: currentUser.profileImageUrl,
                            targetUserId: user!.uid,
                            targetUserName: user.name,
                            targetUserImage: user.profileImageUrl,
                          );
                        }

                        ref.checkIfFollowing(currentUser.uid);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.h, left: 2.w),
                        child: Container(
                          width: 30.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: MyColors.lesspurple,
                            border: Border.all(color: MyColors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Center(
                            child: Text(
                              ref.isFollowing ? 'Unfollow' : 'Follow',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: MyColors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 3.h,
                left: 4.w,
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h, left: 2.w),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 24.sp),
                    color: MyColors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 21.h - 7.h,
                left: MediaQuery.of(context).size.width / 2 - 10.h,
                child: Container(
                  width: 20.h,
                  height: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 1.5.w),
                  ),
                  child: CircleAvatar(
                    radius: 50.sp,
                    backgroundColor: Colors.grey,
                    backgroundImage: (user?.profileImageUrl != '' &&
                            user?.profileImageUrl != null)
                        ? NetworkImage(user!.profileImageUrl)
                        : null, // Use NetworkImage for online images
                    child: user?.profileImageUrl == ''
                        ? Icon(
                            Icons.person,
                            size: 50.sp,
                            color: MyColors.white,
                          )
                        : null, // Fallback icon if no image
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            user?.name ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            user?.lives_in ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: MyColors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 2.h, bottom: 1.h),
            child: Row(
              spacing: 2.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Center(
                    child: Row(
                      spacing: 2.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user?.followers.length.toString() ?? '0',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: MyColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 30.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: MyColors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 2.w,
                      children: [
                        Text(
                          user?.following.length.toString() ?? '0',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          'Following',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: MyColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: 2.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage('assets/blankglobe.png'),
                  width: 5.h,
                  height: 5.h),
              Image(
                  image: AssetImage('assets/blankinsta.png'),
                  width: 5.h,
                  height: 5.h),
              Image(
                  image: AssetImage('assets/blankfb.png'),
                  width: 5.h,
                  height: 5.h),
            ],
          ),
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  TabBar(
                    labelColor: MyColors.purple,
                    unselectedLabelColor: MyColors.grey,
                    indicatorColor: MyColors.purple,
                    tabs: const [
                      Tab(text: 'Posts'),
                      Tab(text: 'Collections'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        // --- Posts Tab ---
                        GridView.builder(
                          padding: EdgeInsets.all(2.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 2.w,
                          ),

                          itemCount: post.length, // Replace with posts.length
                          itemBuilder: (context, index) {
                            final singlePost = post[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.view_post,
                                    arguments: singlePost);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyColors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Image(
                                  image: NetworkImage(singlePost.mediaUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),

                        // --- Collections Tab ---
                        GridView.builder(
                          padding: EdgeInsets.all(2.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 2.w,
                          ),
                          itemCount: collections.length,
                          itemBuilder: (context, index) {
                            final collection = collections[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context,
                                    RoutesName.view_posts_by_collection,
                                    arguments: collection);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MyColors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: ClipRRect(
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Image.network(
                                          collections[index].coverImageUrl,
                                          height: 30.h,
                                          width: 60.w,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          height: 30.h,
                                          width: 60.w,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Colors.black
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.symmetric(
                                                  horizontal: 4.w,
                                                  vertical: 2.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                collections[index]
                                                    .title
                                                    .toUpperCase(),
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.2,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
