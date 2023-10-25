import 'package:flutter/material.dart';
import 'package:plant/screens/details/components/image_and_icon_card.dart';

import 'name_and_price.dart';

class Body extends StatelessWidget {
  String? plantName;
  String? date;
  String? location;
  String? upzilla;
  String? district;
  String? division;
  double? price;
  String plantImage;
  String? note;
  String? sellerID;
  String? sellerName;
  int? totalPlants;
  int? soldPlants;
  bool? isNote;
  Body({
    super.key,
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
    required this.isNote,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ImageAndIconCard(
            plantImage: plantImage,
            plantName: plantName!,
            price: price.toString(),
          ),
          NameTitlePrice(
            sellerName: sellerName!,
            location: location!,
            price: price.toString()!,
            note: note!,
            division: division!,
            district: district!,
            upzilla: upzilla!,
            soldPlants: soldPlants!,
            totalPlants: totalPlants!,
            plantName: plantName!,
            date: date!,
            isNote: isNote!,
          ),
        ],
      ),
    );
  }
}
