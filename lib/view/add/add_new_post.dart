import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:nazaria/viewmodel/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CollPostViewModel>(context, listen: false)
          .fetchUserCollections(
        Provider.of<UserProvider>(context, listen: false).currentUser.uid,
      );
    });
  }

  File? _mediaFile;
  final TextEditingController _captionController = TextEditingController();

  Future<void> _pickMedia() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mediaFile = File(pickedFile.path);
      });
    }
  }

  String? _selectedCollection;

  @override
  Widget build(BuildContext context) {
    final collections = Provider.of<CollPostViewModel>(context).collections;
    final user = Provider.of<UserProvider>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            EdgeInsetsDirectional.symmetric(horizontal: 5.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Column(
            spacing: 2.h,
            children: [
              GestureDetector(
                onTap: _pickMedia,
                child: _mediaFile != null
                    ? Image.file(_mediaFile!, height: 200)
                    : Container(
                        height: 24.h,
                        width: double.infinity,
                        color: MyColors.lessgrey,
                        child: const Center(child: Text("Tap to select media")),
                      ),
              ),
              TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  labelText: "Caption",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: _selectedCollection,
                hint: const Text("Select Collection"),
                items: collections.map((collectionId) {
                  return DropdownMenuItem<String>(
                    value: collectionId.collectionId,
                    child: Text(collectionId.title),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCollection = value;
                  });
                },
              ),
              Consumer<CollPostViewModel>(builder: (context, ref, child) {
                return ElevatedButton.icon(
                  onPressed: () {
                    ref.addNewPost(
                        mediaFile: _mediaFile!,
                        userId: user.uid,
                        caption: _captionController.text,
                        category: user.category,
                        collectionId: _selectedCollection!,
                        context: context,
                        userName: user.name,
                        userProfileUrl: user.profileImageUrl);
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text("Upload Post"),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
