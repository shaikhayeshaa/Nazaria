import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nazaria/model/coll_model.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewPostsByCollection extends StatefulWidget {
  const ViewPostsByCollection({super.key});

  @override
  State<ViewPostsByCollection> createState() => _ViewPostsByCollectionState();
}

class _ViewPostsByCollectionState extends State<ViewPostsByCollection> {
  CollectionModel? collection;

  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (collection == null) {
      collection =
          ModalRoute.of(context)!.settings.arguments as CollectionModel;
      // Schedule this after build is complete
      Future.microtask(() {
        Provider.of<CollPostViewModel>(context, listen: false)
            .fetchPostsByCollection(collection!.collectionId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final collectionLocal = collection!;
    final post = Provider.of<CollPostViewModel>(context).posts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          collectionLocal.title,
          style:
              GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(2.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.w,
                mainAxisSpacing: 2.w,
              ),
              itemCount: post.length,
              itemBuilder: (context, index) {
                final singlePost = post[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.view_post,
                        arguments: singlePost);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.grey, width: 1),
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
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
