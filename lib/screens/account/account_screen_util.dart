import 'package:flutter/material.dart';

import '../../constants.dart';

BoxDecoration accountScreenBoxDecoration = BoxDecoration(
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

Widget AccountScreenWidget(
    {String? title,
    String? data,
    IconData? iconData,
    required BuildContext context}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.12,
    padding: EdgeInsets.all(15),
    decoration: accountScreenBoxDecoration,
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
