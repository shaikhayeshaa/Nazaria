import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:nazaria/viewmodel/view_user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Categouries extends StatefulWidget {
  const Categouries({super.key});

  @override
  State<Categouries> createState() => _CategouriesState();
}

class _CategouriesState extends State<Categouries> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CollPostViewModel>(context, listen: false).fetchCollections();
      Provider.of<ViewUserViewModel>(context, listen: false).fetchAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final collections = Provider.of<CollPostViewModel>(context).collections;
    final users = Provider.of<ViewUserViewModel>(context).users;
    final colprovider = Provider.of<CollPostViewModel>(context);
    print(collections.length);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 2.h, start: 3.w, bottom: 1.h),
                child: Text("Connect With Professionals",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: users.length, // change as needed
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                            height: 10.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: MyColors.verylesspurple,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                        context, RoutesName.viewuserprofile,
                                        arguments: users[index].uid)
                                    .then((_) {
                                  colprovider.fetchCollections();
                                  colprovider.fetchAllPosts();
                                });
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    spacing: 1.w,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.w),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            users[index].category.toUpperCase(),
                                            style: GoogleFonts.poppins(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        users[index].name,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 3.w),
                                    child: Container(
                                      height: 10.h,
                                      width: 10.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  users[index].profileImageUrl),
                                              fit: BoxFit.cover)),
                                    ),
                                  )
                                ],
                              ),
                            )));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 2.h, start: 3.w, bottom: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Topic",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Text("View more",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.deepPurple,
                        )),
                  ],
                ),
              ),
              Consumer<CollPostViewModel>(builder: (context, ref, child) {
                return SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                          onTap: () {
                            ref.fetchAllCollectionsByCategory('photographer');
                            Navigator.pushNamed(
                                    context, RoutesName.viewAllCollections,
                                    arguments: 'photographer')
                                .then((_) {
                              ref.fetchCollections();
                            });
                          },
                          child: _buildTopicCard(
                              "PHOTOGRAPHY", "assets/nonamep.png")),
                      SizedBox(
                        width: 2.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            ref.fetchAllCollectionsByCategory('designer');
                            Navigator.pushNamed(
                                    context, RoutesName.viewAllCollections,
                                    arguments: 'designer')
                                .then((_) {
                              ref.fetchCollections();
                            });
                          },
                          child: _buildTopicCard(
                              "UI DESIGN", "assets/nonamed.png")),
                      SizedBox(
                        width: 2.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            ref.fetchAllCollectionsByCategory('illustrator');
                            Navigator.pushNamed(
                                    context, RoutesName.viewAllCollections,
                                    arguments: 'illustrator')
                                .then((_) {
                              ref.fetchCollections();
                            });
                          },
                          child: _buildTopicCard(
                              "ILLUSTRATION", "assets/nonamei.png")),
                      SizedBox(
                        width: 2.w,
                      ),
                      GestureDetector(
                          onTap: () {
                            ref.fetchAllCollectionsByCategory('video_editor');
                            Navigator.pushNamed(
                                    context, RoutesName.viewAllCollections,
                                    arguments: 'video_editor')
                                .then((_) {
                              ref.fetchCollections();
                            });
                          },
                          child: _buildTopicCard(
                              "Video Editing", "assets/nonameve.png")),
                    ],
                  ),
                );
              }),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 2.h, start: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Collection",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    Text("View more",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.deepPurple,
                        )),
                  ],
                ),
              ),
              Consumer<CollPostViewModel>(builder: (context, ref, child) {
                if (ref.collections.isEmpty) {
                  return SizedBox(
                      height: 18.h,
                      child: Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 6.sp,
                      )));
                }

                return Padding(
                  padding: EdgeInsetsDirectional.only(top: 1.h),
                  child: SizedBox(
                    height: 18.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: collections.length, // change as needed
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                    context, RoutesName.viewAllPosts,
                                    arguments: collections[index].collectionId)
                                .then((_) {
                              ref.fetchAllPosts();
                            });
                            ref.fetchPostsByCollection(
                                collections[index].collectionId);
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(end: 4.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.sp),
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Image.network(
                                    collections[index].coverImageUrl,
                                    height: 18.h,
                                    width: 60.w,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height: 18.h,
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
                                    padding: EdgeInsetsDirectional.symmetric(
                                        horizontal: 4.w, vertical: 2.h),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTopicCard(String label, String imgPath) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(14),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(imgPath, height: 100, width: 160, fit: BoxFit.cover),
        Container(
          height: 100,
          width: 160,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Text(label,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ],
    ),
  );
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Categouries extends StatelessWidget {
//   const Categouries({super.key});

//   @override
//   Widget build(BuildContext context) {
  
//       return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSearchBar(),
//               const SizedBox(height: 16),
//               _buildSectionTitle("Topic"),
//               const SizedBox(height: 12),
//               _buildHorizontalTopics(),
//               const SizedBox(height: 20),
//               _buildSectionTitle("Collection"),
//               const SizedBox(height: 12),
//               _buildHorizontalCollections(),
//               const SizedBox(height: 20),
//               _buildSectionTitle("Collection"),
//               const SizedBox(height: 12),
//               _buildHorizontalCollections(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Search',
//           border: InputBorder.none,
//           icon: const Icon(Icons.search),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title,
//             style: GoogleFonts.poppins(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             )),
//         Text("View more",
//             style: GoogleFonts.poppins(
//               fontSize: 13,
//               color: Colors.deepPurple,
//             )),
//       ],
//     );
//   }



//   Widget _buildHorizontalCollections() {
//     return SizedBox(
//       height: 160,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           _buildCollectionCard(
//               "PORTRAIT\nPHOTOGRAPHY", "70 photos", "assets/photographer.png"),
//           const SizedBox(width: 12),
//           _buildCollectionCard(
//               "MUSIC VIDEO", "10 videos", "assets/photographer.png"),
//           const SizedBox(width: 12),
//           _buildCollectionCard(
//               "NATURE ART", "25 items", "assets/photographer.png"),
//         ],
//       ),
//     );
//   }

//   Widget _buildCollectionCard(String title, String subtitle, String imgPath) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(14),
//       child: Stack(
//         alignment: Alignment.bottomLeft,
//         children: [
//           Image.asset(imgPath, height: 160, width: 200, fit: BoxFit.cover),
//           Container(
//             height: 160,
//             width: 200,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.transparent, Colors.black],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         height: 1.2)),
//                 Text(subtitle,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white70,
//                       fontSize: 12,
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }  