import 'package:flutter/material.dart';
import 'package:nazaria/buildcontext/loc.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/resources/components/main_button.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            top: 28.h,
            bottom: 0,
            left: 0, // ✅ Add this
            right: 0,
            child: Container(
              height: 65.h,
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
                    padding: EdgeInsets.only(
                        top: 4.h, left: 3.w, right: 3.w, bottom: 2.h),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          fillColor: MyColors.lessgrey,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: MyColors.grey,
                          ),
                          hintText: context.loc.email,
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
                      start: 3.w,
                      end: 3.w,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          fillColor: MyColors.lessgrey,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: MyColors.grey,
                          ),
                          hintText: context.loc.password,
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
                        top: 2.h, start: 3.w, end: 3.w, bottom: 2.h),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          context.loc.forgotPassword,
                          style: TextStyle(color: MyColors.blue),
                        )),
                  ),
                  Consumer<AuthViewModel>(builder: (context, ref, child) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(start: 8.w, end: 8.w),
                      child: MainButton(
                          loading: ref.isLoading,
                          title: context.loc.login,
                          onTap: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('fields cannot be empty'),
                                ),
                              );
                            } else {
                              await ref.loginUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                                context: context,
                              );
                            }
                          }),
                    );
                  }),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 3.h, bottom: 1.h),
                    child: Text(context.loc.orLogInBY),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 3.w,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.lessgrey,
                        ),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(1.w),
                          child: Image(image: AssetImage('assets/fb.png')),
                        )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.lessgrey,
                        ),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(1.5.w),
                          child:
                              Image(image: AssetImage('assets/googleicon.png')),
                        )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.loc.dontHaveAnAccount),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.selectCategory);
                          },
                          child: Text(
                            context.loc.signup,
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
