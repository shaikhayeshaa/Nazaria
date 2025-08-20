import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/model/post_model.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:nazaria/viewmodel/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewPost extends StatefulWidget {
  const ViewPost({super.key});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hrs ago';
    return '${diff.inDays} days ago';
  }

  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as PostModel;
    final user = Provider.of<UserProvider>(context).currentUser;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 3.w, end: 3.w, bottom: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 2.w,
                    children: [
                      CircleAvatar(
                        backgroundColor: MyColors.grey,
                        backgroundImage: NetworkImage(post.userProfileUrl),
                        radius: 24.sp,
                      ),
                      Text(post.userName.toUpperCase(),
                          style: GoogleFonts.poppins(fontSize: 18.sp)),
                    ],
                  ),
                  Text(timeAgo(post.timestamp),
                      style: GoogleFonts.poppins(fontSize: 12.sp)),
                ],
              ),
            ),
            Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(post.mediaUrl), fit: BoxFit.cover)),
            ),
            Padding(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 6.w,
                  vertical: 2.h,
                ),
                child:
                    Consumer<CollPostViewModel>(builder: (context, ref, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              ref.togglelike(post.postId, user.uid);
                            },
                            child: Row(
                              spacing: 1.w,
                              children: [
                                Text(
                                  post.likes.length.toString(),
                                  style:
                                      GoogleFonts.poppins(color: MyColors.grey),
                                ),
                                Icon(
                                  post.likes.contains(user.uid)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: post.likes.contains(user.uid)
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Row(
                        spacing: 1.w,
                        children: [
                          Text(
                            post.commentsCount.toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.grey.shade700),
                          ),
                          GestureDetector(
                              onTap: () async {
                                await ref.getComments(post.postId);
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24)),
                                  ),
                                  builder: (context) {
                                    return DraggableScrollableSheet(
                                      expand: false,
                                      initialChildSize: 0.5,
                                      minChildSize: 0.3,
                                      maxChildSize: 0.9,
                                      builder: (context, scrollController) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextField(
                                                        controller:
                                                            commentController,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Add a comment...",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      16),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.send),
                                                      onPressed: () async {
                                                        if (commentController
                                                            .text.isNotEmpty) {
                                                          ref.postComment(
                                                            postId: post.postId,
                                                            userId: user.uid,
                                                            userName: user.name,
                                                            userProfileUrl: user
                                                                .profileImageUrl,
                                                            text:
                                                                commentController
                                                                    .text,
                                                          );
                                                        }
                                                        commentController
                                                            .clear();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  controller: scrollController,
                                                  itemCount:
                                                      ref.comments.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final comment =
                                                        ref.comments[index];
                                                    return ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(comment
                                                                .userProfileUrl),
                                                      ),
                                                      title: Text(
                                                          comment.userName),
                                                      subtitle:
                                                          Text(comment.text),
                                                      trailing: Text(
                                                        timeAgo(
                                                            comment.timestamp),
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "comments",
                                style: GoogleFonts.poppins(),
                              )),
                        ],
                      ),
                    ],
                  );
                })),
            Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 2.w, end: 2.w, bottom: 1.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  post.category,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 2.w, end: 2.w, bottom: 1.h),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    post.caption,
                    style: GoogleFonts.poppins(),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
