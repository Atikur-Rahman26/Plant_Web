import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant/constants.dart';
import 'package:plant/screens/details/components/icon_card.dart';

class ImageAndIconCard extends StatelessWidget {
  final String plantImage;
  final String plantName;
  final String price;
  ImageAndIconCard({
    required this.plantImage,
    required this.plantName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
      child: SizedBox(
        height: size.height * 0.65,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.75,
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding * 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  icon: SvgPicture.asset(
                                      'assets/icons/back_arrow.svg'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: kDefaultPadding * 2,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconCard(
                                      image: 'assets/icons/sun.svg',
                                      onPressed: () {},
                                    ),
                                    IconCard(
                                      image: 'assets/icons/icon_2.svg',
                                      onPressed: () {},
                                    ),
                                    IconCard(
                                      image: 'assets/icons/icon_3.svg',
                                      onPressed: () {},
                                    ),
                                    IconCard(
                                      image: 'assets/icons/icon_4.svg',
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.55,
                    width: size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        bottomLeft: Radius.circular(63),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 60,
                          color: kPrimaryColor.withOpacity(0.29),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        bottomLeft: Radius.circular(63),
                      ),
                      child: Image.network(
                        plantImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${plantName}',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: kPrimaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'tk ${price}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: kTextColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
