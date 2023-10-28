import 'package:flutter/material.dart';
import 'package:plant/domain/add_sell_post_data.dart';
import 'package:plant/screens/sell/add_sell_post/add_sell_post.dart';

import '../../constants.dart';

class PreviousSellPost extends StatelessWidget {
  static SellPostsData sellPosts = SellPostsData(
      plantName: "plantName",
      plantID: "plantID",
      plantImage: "plantImage",
      date: "date",
      location: "location",
      upzilla: "upzilla",
      district: "district",
      division: "division",
      price: 0,
      note: "note",
      soldPlants: 0,
      totalPlants: 5,
      sellerName: "sellerName",
      sellerID: "sellerID");
  String plantImage;
  String plantName;
  String plnatId;
  int soldPlant;
  int totalPlant;
  double price;
  bool isSoldOut;
  PreviousSellPost(
      {required this.plantImage,
      required this.plantName,
      required this.plnatId,
      required this.soldPlant,
      required this.totalPlant,
      required this.price,
      required this.isSoldOut});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AddSellPost.sellPostsData = sellPosts;
        AddSellPost.forEditing = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddSellPost(),
          ),
        );
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom: 10, top: 10),
        padding: EdgeInsets.only(left: 15, bottom: 10, top: 5),
        decoration: const BoxDecoration(
          color: kCartBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.25,
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Image.network(
                    plantImage,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        previousSellPostTextWidget(
                            size: 25, text: plantName, isThisTk: false),
                        previousSellPostTextWidget(
                            size: 20, text: "${price}", isThisTk: true),
                        Text(
                          "Sold plants:${soldPlant}/${totalPlant}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: kTextColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget previousSellPostTextWidget(
      {String? text, required double size, bool? isThisTk}) {
    return Text(
      isThisTk! ? "TK ${text!}" : "${text!}",
      style: TextStyle(
          fontSize: size, fontWeight: FontWeight.bold, color: kTextColor),
    );
  }

  Widget soldOutWidget() {
    return Container();
  }
}
