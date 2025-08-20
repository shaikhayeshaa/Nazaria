import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nazaria/resources/notifications/notification_services.dart';
import 'package:nazaria/util/routes/routes.dart';
import 'package:nazaria/util/routes/routes_name.dart';
import 'package:nazaria/util/shared_prefs/shared_prefs.dart';
import 'package:nazaria/util/theme/theme_provider.dart';
import 'package:nazaria/viewmodel/col_and_post_viewmodel.dart';
import 'package:nazaria/viewmodel/auth_viewmodel.dart';
import 'package:nazaria/viewmodel/user_provider.dart';
import 'package:nazaria/viewmodel/view_user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationHelper.show(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.instance.subscribeToTopic('all');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    NotificationHelper.show(message);
  });
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  NotificationHelper.initialise();
  await SharedPrefs.init();

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CollPostViewModel(),
          ),
          ChangeNotifierProvider(create: (context) => ViewUserViewModel()),
        ],
        child: ResponsiveSizer(
          builder: (buildContext, orientation, screenType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.splash,
              onGenerateRoute: Routes.generateRoute,
              theme: Provider.of<ThemeProvider>(context).themeData,
            );
          },
        ));
  }
}
