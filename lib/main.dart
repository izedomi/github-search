
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'controllers/login_validation_controller.dart';
import 'controllers/sort_tab_setting_controller.dart';
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/account.dart';
import 'screens/splash.dart';
import './screens/github_user.dart';



void main() {
  runApp(

     MultiProvider(
       providers: [
          ChangeNotifierProvider(create: (_) => LoginValidation()),
          ChangeNotifierProvider(create: (_) => SortingTabSetting()),
       ],
       child: MyApp(),
     )
   
  );
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHubSearch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Color(0xff89CBF0),
        primaryColor: Color(0xff094063),
        fontFamily: 'Montserrat'
      ),
      home: SplashScreen(),
      routes: {
          '/splash': (BuildContext context) => SplashScreen(),
          '/login' : (BuildContext context) => LoginScreen(),
          '/home' : (BuildContext context) => HomeScreen(),
          '/github' : (BuildContext context) => GithubSearchScreen(),
          '/account': (BuildContext context) => AccountScreen(),
    
      },
    );
  }
}




