import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:nazaria/viewmodel/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CollPostViewModel>(context, listen: false).fetchAllPosts();
    });
  }

  Future getComments(String postId) async {
    final viewModel = Provider.of<CollPostViewModel>(context, listen: false);
    await viewModel.getComments(postId);
    return viewModel.comments;
  }

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
    final posts = Provider.of<CollPostViewModel>(context).posts;
    final user = Provider.of<UserProvider>(context).currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 6.h, start: 4.w, end: 4.w),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.surface,
                  hintText: 'Search',
                  hintStyle: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabItem("Popular", isActive: true),
                _buildTabItem("Trending"),
                _buildTabItem("Following"),
              ],
            ),
          ),
          Consumer<CollPostViewModel>(
            builder: (context, ref, child) {
              if (ref.posts.isEmpty) {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 6.sp,
                ));
              }
              return Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                        bottom: 4.w, start: 4.w, end: 4.w),
                    child: Container(
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: MyColors.lesspurple,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.viewuserprofile,
                                  arguments: post.userId,
                                ).then((_) {
                                  ref.fetchAllPosts();
                                });
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(post.userProfileUrl),
                                ),
                                title: Text(
                                  post.userName.toUpperCase(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Text(timeAgo(post.timestamp),
                                    style:
                                        TextStyle(color: Colors.grey.shade500)),
                              ),
                            ),
                            Consumer<CollPostViewModel>(
                                builder: (context, ref, child) {
                              if (ref.posts[index].caption != "") {
                                return Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 4.w, bottom: 1.w),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      post.caption,
                                      style: GoogleFonts.alata(
                                          fontSize: 16.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),
                            SizedBox(
                              height: 40.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Image.network(
                                    post.mediaUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            Text(post.likes.length.toString()),
                                            Icon(
                                              post.likes.contains(user.uid)
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color:
                                                  post.likes.contains(user.uid)
                                                      ? MyColors.purple
                                                      : MyColors.grey,
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
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            await getComments(post.postId);
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            24)),
                                              ),
                                              builder: (context) {
                                                return DraggableScrollableSheet(
                                                  expand: false,
                                                  initialChildSize: 0.5,
                                                  minChildSize: 0.3,
                                                  maxChildSize: 0.9,
                                                  builder: (context,
                                                      scrollController) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        commentController,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          "Add a comment...",
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16),
                                                                      ),
                                                                      contentPadding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              16),
                                                                    ),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .send),
                                                                  onPressed:
                                                                      () async {
                                                                    if (commentController
                                                                        .text
                                                                        .isNotEmpty) {
                                                                      ref.postComment(
                                                                        postId:
                                                                            post.postId,
                                                                        userId:
                                                                            user.uid,
                                                                        userName:
                                                                            user.name,
                                                                        userProfileUrl:
                                                                            user.profileImageUrl,
                                                                        text: commentController
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
                                                            child: ListView
                                                                .builder(
                                                              controller:
                                                                  scrollController,
                                                              itemCount: ref
                                                                  .comments
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                final comment =
                                                                    ref.comments[
                                                                        index];
                                                                return ListTile(
                                                                  leading:
                                                                      CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            comment.userProfileUrl),
                                                                  ),
                                                                  title: Text(
                                                                      comment
                                                                          .userName),
                                                                  subtitle: Text(
                                                                      comment
                                                                          .text),
                                                                  trailing:
                                                                      Text(
                                                                    timeAgo(comment
                                                                        .timestamp),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .grey,
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
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, {bool isActive = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: isActive ? Colors.deepPurple : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
