import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/home/components/recommend_plants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          RecommendPlants(),
          SizedBox(
            height: kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
