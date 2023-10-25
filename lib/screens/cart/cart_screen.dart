import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/data/carts_data.dart';
import 'package:plant/domain/carts.dart';
import 'package:plant/screens/cart/cart_list_widgets.dart';
import 'package:plant/screens/home/home_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isAnythingInCart = false;
  CartsData _cartsData = CartsData();
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
                var selectedItem =
                    int.parse(cartsListData['currentSelectItem'].toString());
                var price =
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

                var cartsWidgetLists = CartListWidget(
                    plantName: plantName,
                    plantImage: plantImage,
                    selectedItem: selectedItem,
                    price: price * selectedItem,
                    buyNowPressed: () async {
                      int soldItem =
                          await _cartsData.currentSoldItem(plantId: cartId);
                      int availableItem =
                          await _cartsData.availAbleTotalItem(plantId: cartId);

                      bool _isClicked = await _cartsData.updateCartAndPlant(
                          carts: Carts(
                              buyerId: buyerId,
                              buyerName: buyerName,
                              cartId: cartId,
                              plantName: plantName,
                              plantSellerID: plantSellerID,
                              plantSellerName: plantSellerName,
                              perItemPrice: price,
                              totalItem: totalItem,
                              plantImage: plantImage,
                              currentSelectItem: selectedItem,
                              availableItem: availableItem),
                          previousSold: soldItem);

                      _isClicked = await _cartsData.deleteCart(
                          username: HomeScreen.user.userName, plantId: cartId);
                      while (_isClicked != true) {
                        _isClicked = await _cartsData.deleteCart(
                            username: HomeScreen.user.userName,
                            plantId: cartId);
                      }
                    },
                    cancelPressed: () async {
                      bool _isClicked = await _cartsData.deleteCart(
                          username: HomeScreen.user.userName, plantId: cartId);
                      while (_isClicked != true) {
                        _isClicked = await _cartsData.deleteCart(
                            username: HomeScreen.user.userName,
                            plantId: cartId);
                      }
                    },
                    minusPressed: () {
                      setState(() {
                        selectedItem = selectedItem - 1;
                        if (selectedItem < 1) {
                          selectedItem = 1;
                        }
                        _cartsData.updateSelectedCart(
                            currentSelectItem: selectedItem, cartId: cartId);
                      });
                      print("${selectedItem}");
                    },
                    plusPressed: () async {
                      int sold =
                          await _cartsData.currentSoldItem(plantId: cartId);
                      int available =
                          await _cartsData.availAbleTotalItem(plantId: cartId);
                      setState(() {
                        selectedItem = selectedItem + 1;
                        if (selectedItem > (available - sold)) {
                          selectedItem = available - sold;
                        }
                        _cartsData.updateSelectedCart(
                            currentSelectItem: selectedItem, cartId: cartId);
                      });
                      print("${selectedItem}");
                    });
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
