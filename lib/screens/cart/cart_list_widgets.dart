import 'package:flutter/material.dart';

import '../../constants.dart';

class CartListWidget extends StatelessWidget {
  final String plantName;
  final String plantImage;
  final int selectedItem;
  final double price;
  final VoidCallback buyNowPressed;
  final VoidCallback cancelPressed;
  final VoidCallback minusPressed;
  final VoidCallback plusPressed;
  CartListWidget(
      {required this.plantName,
      required this.plantImage,
      required this.selectedItem,
      required this.price,
      required this.buyNowPressed,
      required this.cancelPressed,
      required this.minusPressed,
      required this.plusPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "${plantName}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.20,
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                    bottom: 5,
                  ),
                  child: Image.network(
                    plantImage,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tk. ${price! * selectedItem!}",
                      style: cartTextStyle(size: 25),
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: minusPressed,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              "assets/images/minus.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "${selectedItem}",
                          style: cartTextStyle(size: 25),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: plusPressed,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Image.asset(
                              "assets/images/add.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: TextButton(
                  onPressed: buyNowPressed,
                  child: const Text(
                    "Buy now",
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: kBackgroundRedColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: TextButton(
                  onPressed: cancelPressed,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 20,
          ),
        ],
      ),
    );
  }
}
