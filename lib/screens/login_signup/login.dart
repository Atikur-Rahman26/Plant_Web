import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant/constants.dart';
import 'package:plant/data/user_details.dart';
import 'package:plant/data/user_functionality.dart';
import 'package:plant/domain/users.dart';
import 'package:plant/main.dart';
import 'package:plant/screens/home/home_screen.dart';
import 'package:plant/screens/login_signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const id = "Login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Users? users;
  final UserDataProvider userDataProvider = UserDataProvider();
  EdgeInsets containerPadding = const EdgeInsets.only(
    left: 15,
    right: 15,
    top: 5,
  );

  EdgeInsets containerMargin = const EdgeInsets.only(
    left: 10,
    right: 10,
    bottom: 10,
    top: 10,
  );
  BoxDecoration containerBoxDecoration = const BoxDecoration(
    color: kCartBackgroundColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
  );
  UserFunctionalities userFunctionalities = UserFunctionalities();
  late String emailAddress;
  late String password;
  bool _clickedEmailAddress = false;
  bool _clickedPassword = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: containerPadding,
              margin: containerMargin,
              decoration: containerBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _clickedEmailAddress == true ? "Email" : "",
                    style: const TextStyle(color: kTextColor, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    style: const TextStyle(
                      color: kTextColor,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        emailAddress = value;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: _clickedEmailAddress
                          ? null
                          : const Icon(
                              Icons.email_outlined,
                              size: 30,
                            ),
                      suffixIconColor: kTextColor,
                      focusColor: kPrimaryColor,
                      hintStyle: const TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      hintText: _clickedEmailAddress == false ? 'Email' : null,
                    ),
                    onTap: () {
                      setState(() {
                        _clickedEmailAddress = true;
                        _clickedPassword = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: containerPadding,
              margin: containerMargin,
              decoration: containerBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _clickedPassword == true ? "Password" : "",
                    style: const TextStyle(color: kTextColor, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  TextField(
                    obscureText: true,
                    style: const TextStyle(
                      color: kTextColor,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: _clickedPassword == false
                          ? const Icon(
                              Icons.password,
                              size: 30,
                              color: kTextColor,
                            )
                          : null,
                      suffixIconColor: kTextColor,
                      focusColor: kPrimaryColor,
                      hintStyle: const TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      hintText: _clickedPassword == false ? 'Password' : null,
                    ),
                    onTap: () {
                      setState(() {
                        _clickedEmailAddress = false;
                        _clickedPassword = true;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: containerPadding,
              margin: containerMargin,
              decoration:
                  containerBoxDecoration.copyWith(color: kCartBackgroundColor),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  int b = await userFunctionalities.userValid(
                      email: emailAddress, password: password);
                  if (b == 1) {
                    setState(() {
                      _isLoading = false;
                    });
                    users = await userDataProvider.getUserData();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs?.setStringList(MyApp.userKey, <String>[
                      '${users!.email}',
                      '${users!.userName}',
                      '${users!.fullName}',
                      '${users!.userImage}',
                      '${users!.phoneNumber}',
                      '${users!.userDateOfBirth}'
                    ]);
                    await prefs?.setBool(MyApp.loginKey, true);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          users: users!,
                        ),
                      ),
                    );
                  } else if (b == 2) {
                    setState(() {
                      _isLoading = false;
                    });
                    print("User not found");
                  } else if (b == 3) {
                    setState(() {
                      _isLoading = false;
                    });
                    print("wrong password");
                  }
                },
                child: const Text(
                  "Log in",
                  style: TextStyle(fontSize: 25, color: kTextColor),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUp.id);
              },
              child: const Text(
                "new here?sign up",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 25,
                ),
              ),
            ),
            Center(
              child: _isLoading
                  ? const SpinKitFadingCircle(
                      color: kTextColor,
                      size: 100,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
