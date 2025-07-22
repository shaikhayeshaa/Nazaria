import 'package:flutter/material.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.splash,
              onGenerateRoute: Routes.generateRoute,
              theme: Provider.of<ThemeProvider>(context).themeData,
            );
          },
        ));
  }
}
