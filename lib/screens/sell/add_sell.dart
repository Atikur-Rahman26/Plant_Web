import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/domain/add_sell_post_data.dart';
import 'package:plant/screens/sell/add_sell_post/add_sell_post.dart';

class AddSell extends StatefulWidget {
  const AddSell({super.key});

  @override
  State<AddSell> createState() => _AddSellState();
}

class _AddSellState extends State<AddSell> {
  String sellBackgroundImage = "assets/images/green.jpeg";
  bool isThereAnySellPost =
      false; //it's for checking that you have any previous sell post or not
  List<SellPostsData> previousSellPost = [
    SellPostsData(
        plantID: "AtikAmGach07102023",
        soldPlants: 1,
        totalPlants: 5,
        plantName: "Am gach",
        plantImage: "assets/images/image_1.png",
        location: "Kararchor",
        upzilla: "Shibpur",
        district: "Narsigndi",
        division: "Dhaka",
        price: 445,
        date: "07-10-2023",
        sellerID: "Atik",
        sellerName: "Atikur Rahman",
        note: 'Good to see')
  ];
  List<Widget> getPreviousSellPost() {
    List<Widget> lists = [];
    for (int i = 0; i < previousSellPost.length; i++) {
      lists.add(GestureDetector(
        onTap: () {},
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.25,
              margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Image.asset(
                previousSellPost[i].plantImage!,
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
                        size: 25,
                        text: previousSellPost[i].plantName,
                        isThisTk: false),
                    previousSellPostTextWidget(
                        size: 20,
                        text: "${previousSellPost[i].price!}",
                        isThisTk: true),
                    Text(
                      "Sold plants:${previousSellPost[i].soldPlants}/${previousSellPost[i].totalPlants}",
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
        ),
      ));
    }
    return lists;
  }

  List<Widget> noSellPostWidget() {
    List<Widget> lists = [
      const Center(
        child: Text(
          "No data found!",
          style: TextStyle(
            color: kTextColor,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const Icon(
        Icons.info_outline,
        size: 300,
        color: kTextColorGreyType,
      ),
    ];

    return lists;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isThereAnySellPost = previousSellPost.length == 0 ? false : true;
    });
    return Scaffold(
      body: Container(
        color: kBackgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(sellBackgroundImage),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Want to make a sell post?",
                    style: TextStyle(
                        color: kBackgroundColor,
                        fontSize: 30,
                        fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kButtonBackgroundColor),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AddSellPost.id);
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: isThereAnySellPost
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: isThereAnySellPost
                      ? getPreviousSellPost()
                      : noSellPostWidget(),
                ),
              ),
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
}
