import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/home/home_screen.dart';
import 'package:plant/screens/sell/add_sell_post/add_sell_post.dart';
import 'package:plant/screens/sell/previous_sell_post_widget.dart';

class AddSell extends StatefulWidget {
  const AddSell({super.key});

  @override
  State<AddSell> createState() => _AddSellState();
}

class _AddSellState extends State<AddSell> {
  String sellBackgroundImage = "assets/images/green.jpeg";
  bool isThereAnySellPost =
      false; //it's for checking that you have any previous sell post or not

  @override
  Widget build(BuildContext context) {
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
                child: StreamBuilder<DatabaseEvent>(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child('ownSellPosts/${HomeScreen.user.userName}')
                  .onValue,
              builder: (context, snapshot) {
                List<PreviousSellPost> previousSellsWidget = [];
                if (snapshot.hasData) {
                  DataSnapshot data = snapshot.data!.snapshot;

                  if (data.value != null &&
                      data.value is Map<Object?, Object?>) {
                    Map<Object?, Object?> comments =
                        data.value as Map<Object?, Object?>;
                    List<Map<Object?, Object?>> previousSellPostsList = [];
                    comments.forEach((key, value) {
                      if (value is Map<Object?, Object?>) {
                        previousSellPostsList.add(value);
                      }
                    });

                    for (var previousSellsData in previousSellPostsList) {
                      final plantName =
                          previousSellsData['plantName'].toString();
                      final plantImage =
                          (previousSellsData['plantImage'].toString());
                      var soldItem =
                          int.parse(previousSellsData['soldPlants'].toString());
                      var price =
                          double.parse(previousSellsData['price'].toString());
                      final date = previousSellsData['date'];
                      final division = previousSellsData['division'].toString();
                      final district = previousSellsData['district'].toString();
                      final upzilla = previousSellsData['upzilla'].toString();
                      final location = previousSellsData['location'].toString();
                      final plantID = previousSellsData['plantID'].toString();
                      final sellerID = previousSellsData['sellerID'].toString();
                      final sellerName =
                          previousSellsData['sellerName'].toString();
                      final totalItem = int.parse(
                          previousSellsData['totalPlants'].toString());
                      final note = previousSellsData['note'].toString();

                      var cartsWidgetLists = PreviousSellPost(
                          plantImage: plantImage,
                          plantName: plantName,
                          plnatId: plantID,
                          soldPlant: soldItem,
                          totalPlant: totalItem,
                          price: price,
                          isSoldOut: soldItem == totalItem ? true : false);
                      previousSellsWidget.add(cartsWidgetLists);
                    }
                    return ListView(
                      reverse: false,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      children: previousSellsWidget,
                    );
                  }
                }
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                    ],
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
