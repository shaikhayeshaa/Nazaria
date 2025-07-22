import 'package:flutter/material.dart';
import 'package:nazaria/util/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Text(
              'Account',
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h),
            ListTile(
              leading: Icon(Icons.person, size: 5.w),
              title: Text('Edit Profile', style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(Icons.arrow_forward_ios, size: 4.w),
              onTap: () {
                // Handle profile editing
              },
            ),
            ListTile(
              leading: Icon(Icons.lock, size: 5.w),
              title: Text('Change Password', style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(Icons.arrow_forward_ios, size: 4.w),
              onTap: () {
                // Handle password change
              },
            ),
            SizedBox(height: 3.h),
            Text(
              'Preferences',
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Dark Mode', style: TextStyle(fontSize: 16.sp)),
              value: themeProvider.isDarkMode,
              onChanged: (val) {
                themeProvider.toggleTheme();
              },
              secondary: Icon(Icons.dark_mode, size: 5.w),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Notifications', style: TextStyle(fontSize: 16.sp)),
              value: notificationsEnabled,
              onChanged: (val) {
                setState(() {
                  notificationsEnabled = val;
                });
              },
              secondary: Icon(Icons.notifications, size: 5.w),
            ),
            Spacer(),
            Center(
              child: Text(
                'App Version 1.0.0',
                style: TextStyle(fontSize: 15.sp, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
