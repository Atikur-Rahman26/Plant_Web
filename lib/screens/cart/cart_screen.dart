import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/cart/cart_list_widgets.dart';
import 'package:plant/screens/home/home_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isAnythingInCart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cartsWidget(),
    );
  }

  Widget cartsWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance
            .reference()
            .child('Carts/${HomeScreen.user.userName}')
            .onValue,
        builder: (context, snapshot) {
          List<CartListWidget> commentsWidgetList = [];
          if (snapshot.hasData) {
            DataSnapshot data = snapshot.data!.snapshot;

            if (data.value != null && data.value is Map<Object?, Object?>) {
              Map<Object?, Object?> comments =
                  data.value as Map<Object?, Object?>;
              List<Map<Object?, Object?>> commentingList = [];
              comments.forEach((key, value) {
                if (value is Map<Object?, Object?>) {
                  commentingList.add(value);
                }
              });

              for (var cartsListData in commentingList) {
                final plantName = cartsListData['plantName'].toString();
                final plantImage = (cartsListData['plantImage'].toString());
                final selectedItem =
                    int.parse(cartsListData['currentSelectItem'].toString());
                final price =
                    double.parse(cartsListData['perItemPrice'].toString());
                final availableItem = cartsListData['availableItem'];
                final buyerId = cartsListData['buyerId'].toString();
                final buyerName = cartsListData['buyerName'].toString();
                final cartId = cartsListData['cartId'].toString();
                final plantSellerID = cartsListData['plantSellerID'].toString();
                final plantSellerName =
                    cartsListData['plantSellerName'].toString();
                final totalItem =
                    int.parse(cartsListData['totalItem'].toString());

                final cartsWidgetLists = CartListWidget(
                    plantName: plantName,
                    plantImage: plantImage,
                    selectedItem: selectedItem,
                    price: price,
                    buyNowPressed: () {
                      print(cartId);
                    },
                    cancelPressed: () {},
                    minusPressed: () {},
                    plusPressed: () {});
                commentsWidgetList.add(cartsWidgetLists);
              }
              return ListView(
                reverse: false,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                children: commentsWidgetList,
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
                Text(
                  "Empty Cart!",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: kTextColorGreyType),
                ),
                Icon(
                  Icons.info_outline,
                  size: 300,
                  color: kTextColorGreyType,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
