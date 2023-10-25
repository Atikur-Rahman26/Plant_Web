import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/home/components/recommend_plants.dart';

class TitleWithMoreButton extends StatelessWidget {
  final String title, text;
  final VoidCallback onPressed;

  const TitleWithMoreButton(
      {required this.title, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TitleWithCustomUnderline(
            title: title,
          ),
          MaterialButton(
            onPressed: onPressed,
            color: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
