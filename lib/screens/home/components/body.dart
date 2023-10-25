import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/home/components/header_with_seach_box.dart';
import 'package:plant/screens/home/components/recommend_plants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          RecommendPlants(),
          const SizedBox(
            height: kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
