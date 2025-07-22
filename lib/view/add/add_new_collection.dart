import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:nazaria/viewmodel/user_provider.dart';
import 'package:provider/provider.dart';

class AddCollectionScreen extends StatefulWidget {
  const AddCollectionScreen({super.key});

  @override
  State<AddCollectionScreen> createState() => _AddCollectionScreenState();
}

class _AddCollectionScreenState extends State<AddCollectionScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? _coverImage;

  Future<void> _pickCoverImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _coverImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Collection"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickCoverImage,
                child: _coverImage != null
                    ? Image.file(_coverImage!, height: 200)
                    : Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Center(
                            child: Text("Tap to upload cover image")),
                      ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Collection Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Consumer<CollPostViewModel>(builder: (context, ref, child) {
                return ElevatedButton.icon(
                  onPressed: () async {
                    if (_titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Title cannot be empty")),
                      );
                      return;
                    }

                    if (_coverImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please select a cover image")),
                      );
                      return;
                    }

                    await ref.addNewCollection(
                      userId: user.uid,
                      title: _titleController.text,
                      coverImageUrl: _coverImage!.path,
                      category: user.category ?? "general",
                      context: context,
                    );
                  },
                  icon: const Icon(Icons.add_box),
                  label: const Text("Create Collection"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
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
