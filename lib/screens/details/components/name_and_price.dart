import 'package:flutter/material.dart';
import 'package:plant/constants.dart';

class NameTitlePrice extends StatefulWidget {
  final String sellerName,
      location,
      price,
      district,
      division,
      upzilla,
      note,
      date,
      plantName;
  final int? totalPlants;
  final int? soldPlants;
  final bool isNote;

  const NameTitlePrice({
    required this.plantName,
    required this.date,
    required this.price,
    required this.note,
    required this.division,
    required this.sellerName,
    required this.totalPlants,
    required this.district,
    required this.soldPlants,
    required this.upzilla,
    required this.location,
    required this.isNote,
  });
  @override
  State<NameTitlePrice> createState() => _NameTitlePriceState();
}

class _NameTitlePriceState extends State<NameTitlePrice> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.25,
          child: widget.isNote ? noteDetails() : plantDetails(),
        ),
      ),
    );
  }

  Column plantDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '${widget.sellerName}',
          style: Theme.of(context).textTheme.headline4?.copyWith(
              color: kTextColor, fontWeight: FontWeight.bold, fontSize: 35),
        ),
        Text(
          '${widget.location},\t ${widget.upzilla}',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: kTextColor,
                fontWeight: FontWeight.normal,
                fontSize: 30,
              ),
        ),
        Text(
          '${widget.district},\t${widget.division}',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: kTextColor,
                fontWeight: FontWeight.normal,
                fontSize: 30,
              ),
        ),
      ],
    );
  }

  Widget noteDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.note}',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                color: kTextColor, fontWeight: FontWeight.normal, fontSize: 25),
          ),
        ],
      ),
    );
  }
}
