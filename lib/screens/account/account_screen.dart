import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant/constants.dart';
import 'package:plant/domain/user_data.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserData userData = UserData(
    userName: "Atik",
    userID: "Atik",
    userPhoto: "assets/images/Atik.png",
    userEmail: "atikh152@gmail.com",
    userFullName: "Md. Atikur Rahman",
    userPhoneNumber: "01580613255",
    userBirthDate: "09-06-2002",
    userPassword: "atikurrahman",
  );

  BoxDecoration containerBoxDecoration = BoxDecoration(
    color: kCartBackgroundColor,
    border: Border.all(color: kPrimaryColor),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    boxShadow: const [
      BoxShadow(
          color: kPrimaryColor,
          blurRadius: 10,
          offset: Offset(0, 0),
          spreadRadius: 2),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      color: kBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: containerBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(userData.userPhoto),
                    radius: 60,
                  ),
                  Text(
                    "Hi ${userData.userName}",
                    style: const TextStyle(fontSize: 30, color: kTextColor),
                  ),
                  Text(
                    "${userData.userFullName}",
                    style: const TextStyle(fontSize: 30, color: kTextColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ContainerWidgetForAccount(
                title: "Email",
                data: "${userData.userEmail}",
                iconData: Icons.email_outlined),
            const SizedBox(
              height: 20,
            ),
            ContainerWidgetForAccount(
                title: "Phone Number",
                data: "${userData.userPhoneNumber}",
                iconData: Icons.phone),
            const SizedBox(
              height: 20,
            ),
            ContainerWidgetForAccount(
                title: "BirthDate",
                data: "${userData.userBirthDate}",
                iconData: Icons.date_range),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Center(
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        content: Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          decoration: containerBoxDecoration,
                          child: TextField(
                            onChanged: (value) {},
                            style: const TextStyle(
                              color: kTextColor,
                              fontSize: 20,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12)
                            ],
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                decoration: containerBoxDecoration,
                                child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Change",
                                      style: TextStyle(
                                          fontSize: 20, color: kTextColor),
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
                                      style: TextStyle(
                                          fontSize: 20, color: kTextColor),
                                    )),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
                child: ContainerWidgetForAccount(
                    title: "Password",
                    data: "********",
                    iconData: Icons.password))
          ],
        ),
      ),
    );
  }

  Widget ContainerWidgetForAccount(
      {String? title, String? data, IconData? iconData}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      padding: EdgeInsets.all(15),
      decoration: containerBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${title}",
                style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: kTextColor),
              ),
              Icon(
                iconData,
                size: 30,
                color: kTextColor,
              )
            ],
          ),
          Text(
            "${data}",
            style: const TextStyle(fontSize: 30, color: kTextColor),
          ),
        ],
      ),
    );
  }
}
