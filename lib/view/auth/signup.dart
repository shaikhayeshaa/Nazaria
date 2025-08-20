import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/resources/components/main_button.dart';
import 'package:nazaria/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  File? _profileImage;

  Future<void> _selectProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments;
    final authProvider = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: Stack(
        children: [
          Positioned(
              top: 1.h,
              left: 0,
              right: 0,
              child: Image(image: AssetImage('assets/welcome.png'))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: MyColors.white,
              ),
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 3.h),
                    child: GestureDetector(
                      onTap: _selectProfileImage,
                      child: CircleAvatar(
                        radius: 40.sp,
                        backgroundColor: MyColors.lessgrey,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!) as ImageProvider
                            : null,
                        child: _profileImage == null
                            ? Icon(
                                Icons.person,
                                size: 40.sp,
                                color: MyColors.grey,
                              )
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 4.h, start: 3.w, end: 3.w),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          fillColor: MyColors.lessgrey,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.person,
                            color: MyColors.grey,
                          ),
                          hintText: 'Name',
                          hintStyle: TextStyle(color: MyColors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 2.h, start: 3.w, end: 3.w),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          fillColor: MyColors.lessgrey,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: MyColors.grey,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: MyColors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 2.h, start: 3.w, end: 3.w),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          fillColor: MyColors.lessgrey,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: MyColors.grey,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: MyColors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 2.h, start: 3.w, end: 3.w),
                    child: TextFormField(
                      controller: _bioController,
                      decoration: InputDecoration(
                          fillColor: MyColors.lessgrey,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.edit,
                            color: MyColors.grey,
                          ),
                          hintText: 'Bio',
                          hintStyle: TextStyle(color: MyColors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 2.h, start: 3.w, end: 3.w),
                    child: TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                          fillColor: MyColors.lessgrey,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: MyColors.grey,
                          ),
                          hintText: "Lives in",
                          hintStyle: TextStyle(color: MyColors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                    ),
                  ),
                  Consumer<AuthViewModel>(builder: (context, ref, child) {
                    return Padding(
                      padding: EdgeInsets.only(top: 6.h, left: 8.w, right: 8.w),
                      child: MainButton(
                          loading: ref.isLoading,
                          title: "Sign Up",
                          onTap: () async {
                            if (_profileImage != null &&
                                category != null &&
                                _nameController.text.isNotEmpty &&
                                _emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty &&
                                _bioController.text.isNotEmpty &&
                                _cityController.text.isNotEmpty) {
                              return await ref.registerUser(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  lives_in: _cityController.text.trim(),
                                  category: category.toString(),
                                  profileImage: _profileImage!,
                                  context: context);
                            } else if (_profileImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Select Profile Image")));
                            } else if (category == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("You Have To Select Category")));
                            } else if (_nameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Enter Name')));
                            } else if (_emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Enter Email')));
                            } else if (_passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Enter Password')));
                            } else if (_bioController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Enter Bio')));
                            } else if (_cityController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Enter where you live')));
                            }
                          }),
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            ' Sign In',
                            style: TextStyle(color: MyColors.blue),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
