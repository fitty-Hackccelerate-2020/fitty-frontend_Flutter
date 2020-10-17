import 'package:fitty/Page/splash.dart';
import 'package:fitty/services/auth.dart';
import 'package:fitty/services/user_provider.dart';
import 'package:fitty/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Page/AuthPage/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // hangeNotifierPro/vider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        routes: {

        },
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen();
  }
}
