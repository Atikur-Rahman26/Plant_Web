import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/home/home_screen.dart';
import 'package:plant/screens/login_signup/login.dart';
import 'package:plant/screens/login_signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'account_screen_util.dart';

class AccountScreen extends StatefulWidget {
  static String resetPassword = "12";
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var user = HomeScreen.user;
  bool _logOut = false;
  String resetPassword = "pass";
  String otp = "otp";
  String _otp = '12';

  Future<bool> logout() async {
    try {
      FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs
          ?.setStringList(MyApp.userKey, <String>['', '', '', '', '', '']);
      await prefs?.setBool(MyApp.loginKey, false);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      padding: EdgeInsets.only(left: 15, right: 15),
      color: kBackgroundColor,
      child: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            SignUp.users = HomeScreen.user;
                            SignUp.updatingProfile = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          icon: const Icon(
                            Icons.update,
                            size: 45,
                          )),
                      const Text(
                        "Update profile",
                        style: TextStyle(color: kTextColor, fontSize: 20),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _logOut = true;
                      });
                      await logout();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                      setState(() {
                        _logOut = false;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                            onPressed: () async {
                              setState(() {
                                _logOut = true;
                              });
                              await logout();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                              setState(() {
                                _logOut = false;
                              });
                            },
                            icon: const Icon(
                              Icons.logout,
                              size: 30,
                            )),
                        const Text(
                          "Log out",
                          style: TextStyle(color: kTextColor, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: accountScreenBoxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                      future:
                          precacheImage(NetworkImage(user.userImage), context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Icon(
                              Icons.person,
                              size: 90,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return CircleAvatar(
                            backgroundImage:
                                Image.network(user.userImage).image,
                            radius: 60,
                          );
                        }
                      },
                    ),
                    Text(
                      "Hi ${user.userName}",
                      style: const TextStyle(fontSize: 30, color: kTextColor),
                    ),
                    Text(
                      "${user.fullName}",
                      style: const TextStyle(fontSize: 30, color: kTextColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AccountScreenWidget(
                  title: "Email",
                  data: "${user.email}",
                  iconData: Icons.email_outlined,
                  context: context),
              const SizedBox(
                height: 20,
              ),
              AccountScreenWidget(
                  title: "Phone Number",
                  data: "${user.phoneNumber}",
                  iconData: Icons.phone,
                  context: context),
              const SizedBox(
                height: 20,
              ),
              AccountScreenWidget(
                  title: "BirthDate",
                  data: "${user.userDateOfBirth}",
                  iconData: Icons.date_range,
                  context: context),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    editAccountScreenText(context: context);
                  },
                  child: AccountScreenWidget(
                      title: "Update Password",
                      data: "********",
                      iconData: Icons.password,
                      context: context)),
            ],
          ),
        ),
        if (_logOut)
          const Center(
            child: SpinKitFadingCircle(
              color: kTextColor,
              size: 100,
            ),
          )
      ]),
    );
  }

  void editAccountScreenText(
      {String? previousString, required BuildContext context}) {
    String string = "some";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Change Password",
              style: TextStyle(
                  color: kTextColor, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            height: 120,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * .8,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: accountScreenBoxDecoration.copyWith(
                      color: Colors.transparent,
                      border: Border.all(color: kPrimaryColor, width: 5),
                      boxShadow: [BoxShadow(color: Colors.transparent)]),
                  child: TextField(
                    onChanged: (value) {
                      string = value;
                    },
                    decoration: InputDecoration(hintText: "password"),
                    style: const TextStyle(
                      color: kTextColor,
                      fontSize: 20,
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: accountScreenBoxDecoration,
                  child: TextButton(
                      onPressed: () async {
                        resetPassword = string;
                        try {
                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            await user.updatePassword(resetPassword);
                            // Password update successful
                          }
                        } catch (e) {
                          if (e is FirebaseAuthException &&
                              e.code == 'requires-recent-login') {
                            // Handle the "requires-recent-login" error by prompting the user to re-authenticate
                            print(
                                "Error: This operation requires recent authentication. Please log in again.");
                            // You can add code here to guide the user through the reauthentication process
                          } else {
                            // Handle other errors
                            print("Error: $e");
                          }
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Change",
                        style: TextStyle(fontSize: 20, color: kTextColor),
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kCartBackgroundColor,
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.red,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          spreadRadius: 2),
                    ],
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "cancel",
                        style: TextStyle(fontSize: 20, color: kTextColor),
                      )),
                ),
              ],
            )
          ],
        );
      },
      barrierDismissible: false,
    );
  }
}
