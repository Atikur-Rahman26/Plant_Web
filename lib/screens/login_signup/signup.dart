import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plant/domain/users.dart';

import '../../constants.dart';
import '../../data/user_functionality.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  static const id = "SignUp";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
  List<String> userList = [];
  bool _clickedEmail = false;
  bool _clickedPassword = false;
  bool _clickedFullName = false;
  bool _clickedUserName = false;
  bool _clickedUserPhoneNumber = false;
  bool _clickedUserPhotoUpload = false;
  bool _clickedRetypePassword = false;
  bool _usernameExisted = false;

  UserFunctionalities userFunctionalities = UserFunctionalities();

  TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MM-dd-yyyy').format(_selectedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyyy').format(_selectedDate);
    listAssigning();
  }

  void listAssigning() async {
    userList = await userFunctionalities.getAllUserNames();
  }

  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var image = await picker.pickImage(source: media);

    setState(() {
      if (image != null) {
        _clickedUserPhotoUpload = true;
        _userImage = image;
      }
    });
  }

  String userName = '';
  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  String retypePassword = '';
  String userDateOfBirth = '';
  XFile? _userImage;

  TextEditingController _usernameEditiingController = TextEditingController();
  void imagePickingAlertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: const Text(
              "Please choose media to select",
              style: TextStyle(
                  fontSize: 22,
                  color: kTextColor,
                  fontWeight: FontWeight.normal),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: containerPadding,
                margin: containerMargin,
                decoration: BoxDecoration(
                    color: kCartBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    border: Border.all(
                      color: _usernameExisted
                          ? kBackgroundRedColor
                          : Colors.transparent,
                      // color: kBackgroundRedColor,
                      width: 6,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _clickedUserName == true ? "Username" : "",
                      style: const TextStyle(color: kTextColor, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      style: const TextStyle(
                        color: kTextColor,
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          value = removeSpace(str: value);
                          print(value.length);
                          matchedUserName(username: value);
                          userName = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: _clickedUserName
                            ? null
                            : const Icon(
                                Icons.person,
                                size: 30,
                              ),
                        suffixIconColor: kTextColor,
                        focusColor: kPrimaryColor,
                        hintStyle: const TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        hintText: _clickedUserName == false ? 'Username' : null,
                      ),
                      onTap: () {
                        setState(() {
                          _clickedUserName = true;
                          _clickedPassword = false;
                          _clickedEmail = false;
                          _clickedFullName = false;
                          _clickedRetypePassword = false;
                          _clickedUserPhoneNumber = false;
                          _clickedUserPhotoUpload = false;
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
                      _clickedFullName == true ? "Fullname" : "",
                      style: const TextStyle(color: kTextColor, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      style: const TextStyle(
                        color: kTextColor,
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          fullName = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: _clickedFullName == false
                            ? const Icon(
                                Icons.person,
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
                        hintText: _clickedFullName == false ? 'Fullname' : null,
                      ),
                      onTap: () {
                        setState(() {
                          _clickedUserName = false;
                          _clickedPassword = false;
                          _clickedEmail = false;
                          _clickedFullName = true;
                          _clickedRetypePassword = false;
                          _clickedUserPhoneNumber = false;
                          _clickedUserPhotoUpload = false;
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
                      _clickedEmail == true ? "Email" : "",
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
                          email = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: _clickedEmail
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
                        hintText: _clickedEmail == false ? 'Email' : null,
                      ),
                      onTap: () {
                        setState(() {
                          _clickedUserName = false;
                          _clickedPassword = false;
                          _clickedEmail = true;
                          _clickedFullName = false;
                          _clickedRetypePassword = false;
                          _clickedUserPhoneNumber = false;
                          _clickedUserPhotoUpload = false;
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
                      _clickedUserPhoneNumber == true ? "Phone number" : "",
                      style: const TextStyle(color: kTextColor, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      style: const TextStyle(
                        color: kTextColor,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: _clickedUserPhoneNumber == false
                            ? const Icon(
                                Icons.call,
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
                        hintText: _clickedUserPhoneNumber == false
                            ? 'Phone number'
                            : null,
                      ),
                      onTap: () {
                        setState(() {
                          _clickedUserName = false;
                          _clickedPassword = false;
                          _clickedEmail = false;
                          _clickedFullName = false;
                          _clickedRetypePassword = false;
                          _clickedUserPhoneNumber = true;
                          _clickedUserPhotoUpload = false;
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
                width: double.infinity,
                height: 80,
                margin: containerMargin,
                padding: containerMargin,
                decoration: containerBoxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Date of Birth",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        _selectDate(context);
                        _clickedUserName = false;
                        _clickedPassword = false;
                        _clickedEmail = false;
                        _clickedFullName = false;
                        _clickedRetypePassword = false;
                        _clickedUserPhoneNumber = false;
                        _clickedUserPhotoUpload = false;
                      },
                      child: IgnorePointer(
                        child: TextField(
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: 20,
                          ),
                          controller: _dateController,
                        ),
                      ),
                    ))
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
                      keyboardType: TextInputType.number,
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
                          _clickedUserName = false;
                          _clickedPassword = true;
                          _clickedEmail = false;
                          _clickedFullName = false;
                          _clickedRetypePassword = false;
                          _clickedUserPhoneNumber = false;
                          _clickedUserPhotoUpload = false;
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
                      _clickedRetypePassword == true ? "Re-type password" : "",
                      style: const TextStyle(color: kTextColor, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      style: const TextStyle(
                        color: kTextColor,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        setState(() {
                          retypePassword = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: _clickedRetypePassword == false
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
                        hintText: _clickedRetypePassword == false
                            ? 'Re-type Password'
                            : null,
                      ),
                      onTap: () {
                        setState(() {
                          _clickedUserName = false;
                          _clickedPassword = false;
                          _clickedEmail = false;
                          _clickedFullName = false;
                          _clickedRetypePassword = true;
                          _clickedUserPhoneNumber = false;
                          _clickedUserPhotoUpload = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * .75,
                    height: MediaQuery.of(context).size.width * .5,
                    padding: containerPadding,
                    margin: containerMargin,
                    decoration: BoxDecoration(
                      border: Border.all(color: kTextColor),
                    ),
                    child: _clickedUserPhotoUpload
                        ? Image.file(
                            File(_userImage!.path),
                            fit: BoxFit.fill,
                          )
                        : const FittedBox(
                            child: Icon(
                              Icons.photo_size_select_actual_outlined,
                            ),
                          )),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  height: 30,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kCartBackgroundColor),
                    ),
                    onPressed: () {
                      imagePickingAlertBox();
                    },
                    child: const Text(
                      "Upload image",
                      style: TextStyle(fontSize: 20, color: kTextColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MaterialButton(
                  color: kCartBackgroundColor,
                  onPressed: () async {
                    userDateOfBirth = _dateController.text;
                    print(_userImage!.path.isEmpty);
                    if (userName.length == 0 ||
                        fullName.length == 0 ||
                        email.length == 0 ||
                        phoneNumber.length == 0 ||
                        userDateOfBirth.length == 0 ||
                        password.length == 0 ||
                        retypePassword.length == 0 ||
                        _userImage!.path.isEmpty) {
                    } else {
                      if (password != retypePassword) {
                        print("password didn't match");
                      } else {
                        Users users = Users(
                            userDateOfBirth: userDateOfBirth,
                            phoneNumber: phoneNumber,
                            email: email,
                            password: password,
                            fullName: fullName,
                            userName: userName,
                            userImage: _userImage!.path);
                        User? createUser =
                            await userFunctionalities.createAccount(users);
                        if (createUser != null) {
                          Navigator.pushNamed(context, Login.id);
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: MaterialButton(
                  color: kCartBackgroundColor,
                  onPressed: () {},
                  child: const Text(
                    "Already have an account? Sign in",
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void matchedUserName({required String username}) {
    setState(() {
      for (int i = 0; i < userList.length; i++) {
        if (username == userList[i]) {
          _usernameExisted = true;
          return;
        }
      }
      _usernameExisted = false;
      return;
    });
  }

  String removeSpace({required String str}) {
    String temp = '';
    for (int i = 0; i < str.length; i++) {
      if (str[i] != ' ') {
        temp += str[i];
      }
    }
    return temp;
  }
}
