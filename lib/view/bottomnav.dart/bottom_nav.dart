import 'package:flutter/material.dart';
import 'package:nazaria/resources/colors.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/view/activity/activities.dart';
import 'package:nazaria/view/categouries/categouries.dart';
import 'package:nazaria/view/home/home.dart';
import 'package:nazaria/view/profile/profile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    Categouries(),
    Activities(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: isKeyboardOpen
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              elevation: 4,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, RoutesName.addNewCollection);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                margin: EdgeInsets.only(bottom: 2.h),
                                decoration: BoxDecoration(
                                  color: MyColors.lesspurple,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Row(
                                  spacing: 2.w,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.collections_bookmark,
                                      color: MyColors.white,
                                    ),
                                    Text(
                                      'Add New Collection',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, RoutesName.addNewPost);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade100,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Row(
                                  spacing: 2.w,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.post_add,
                                      color: Colors.deepPurple,
                                    ),
                                    Text(
                                      'Add New Post',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                    color:
                        _selectedIndex == 0 ? Colors.deepPurple : Colors.grey),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.window,
                    color:
                        _selectedIndex == 1 ? Colors.deepPurple : Colors.grey),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: Icon(Icons.notifications_active,
                    color:
                        _selectedIndex == 2 ? Colors.deepPurple : Colors.grey),
                onPressed: () => _onItemTapped(2),
              ),
              IconButton(
                icon: Icon(Icons.person,
                    color:
                        _selectedIndex == 3 ? Colors.deepPurple : Colors.grey),
                onPressed: () => _onItemTapped(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
