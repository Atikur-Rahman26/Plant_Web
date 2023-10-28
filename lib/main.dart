import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/home/home_screen.dart';
import 'package:plant/screens/login_signup/login.dart';
import 'package:plant/screens/login_signup/signup.dart';
import 'package:plant/screens/post/post_screen.dart';
import 'package:plant/screens/post/write_edit_post/write_post.dart';
import 'package:plant/screens/sell/add_sell_post/add_sell_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/users.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String loginKey = "LoggedIn";
  static const String userKey = "Users";
  MyApp({super.key});
  late SharedPreferences preferences;

  Future<bool> loggedIn() async {
    preferences = await SharedPreferences.getInstance();
    bool? temp = await preferences.getBool(loginKey);
    if (temp == true) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant ',
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<bool>(
        future: loggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              late Users users;
              List<String>? strlists = preferences.getStringList(userKey);

              print("${snapshot.data}");
              if (strlists != null) {
                String email = strlists![0];
                String username = strlists[1];
                String fullname = strlists[2];
                String userImage = strlists[3];
                String phoneNumber = strlists[4];
                String birthDate = strlists[5];
                HomeScreen.username = username;

                users = Users(
                    userDateOfBirth: birthDate,
                    phoneNumber: phoneNumber,
                    email: email,
                    fullName: fullname,
                    userName: username,
                    userImage: userImage);
                HomeScreen.user = users;
              }
              return snapshot.data == true
                  ? HomeScreen(
                      users: users,
                    )
                  : Login();
            }
          }
        },
      ),
      routes: {
        Login.id: (context) => Login(),
        Post.id: (context) => Post(),
        WritePost.id: (context) => WritePost(),
        AddSellPost.id: (context) => AddSellPost(),
        SignUp.id: (context) => SignUp(),
      },
    );
  }
}
