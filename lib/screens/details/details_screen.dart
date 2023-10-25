import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/data/carts_data.dart';
import 'package:plant/screens/details/components/body.dart';

import '../../domain/carts.dart';
import '../home/home_screen.dart';

class DetailsScreen extends StatefulWidget {
  String plantName;
  String plantId;
  String date;
  String location;
  String upzilla;
  String district;
  String division;
  double price;
  String plantImage;
  String note;
  String sellerID;
  String sellerName;
  int totalPlants;
  int soldPlants;
  bool isNote;
  DetailsScreen(
      {super.key,
      required this.plantId,
      required this.plantName,
      required this.date,
      required this.price,
      required this.note,
      required this.division,
      required this.sellerID,
      required this.sellerName,
      required this.plantImage,
      required this.totalPlants,
      required this.district,
      required this.soldPlants,
      required this.upzilla,
      required this.location,
      required this.isNote});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  CartsData _cartsData = CartsData();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(
        plantName: widget.plantName,
        date: widget.date,
        price: widget.price,
        note: widget.note,
        division: widget.division,
        sellerID: widget.sellerID,
        sellerName: widget.sellerName,
        plantImage: widget.plantImage,
        totalPlants: widget.totalPlants,
        district: widget.district,
        soldPlants: widget.soldPlants,
        upzilla: widget.upzilla,
        location: widget.location,
        isNote: widget.isNote,
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.08,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: kPrimaryColor),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: size.height * 0.08,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50)),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      widget.isNote = false;
                    });
                    bool _isAdded = await _cartsData.addInCart(
                        carts: Carts(
                            buyerId: HomeScreen.user.userName,
                            buyerName: HomeScreen.user.fullName,
                            cartId: widget.plantId,
                            plantName: widget.plantName,
                            plantSellerID: widget.sellerID,
                            plantSellerName: widget.sellerName,
                            perItemPrice: widget.price,
                            totalItem: widget.totalPlants,
                            plantImage: widget.plantImage,
                            availableItem:
                                (widget.totalPlants - widget.soldPlants),
                            currentSelectItem: 1));
                    while (_isAdded != true) {
                      _isAdded = await _cartsData.addInCart(
                          carts: Carts(
                              buyerId: HomeScreen.user.userName,
                              buyerName: HomeScreen.user.fullName,
                              cartId: widget.plantId,
                              plantName: widget.plantName,
                              availableItem:
                                  (widget.totalPlants - widget.soldPlants),
                              plantSellerID: widget.sellerID,
                              plantSellerName: widget.sellerName,
                              perItemPrice: widget.price,
                              totalItem: widget.totalPlants,
                              plantImage: widget.plantImage,
                              currentSelectItem: 1));
                    }
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: size.height * 0.08,
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50)),
                ),
                child: MaterialButton(
                  child: const Text(
                    'Description',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    setState(() {
                      if (widget.isNote) {
                        widget.isNote = false;
                      } else {
                        widget.isNote = true;
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
