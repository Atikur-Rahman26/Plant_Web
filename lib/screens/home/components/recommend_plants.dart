import 'package:flutter/material.dart';
import 'package:plant/constants.dart';
import 'package:plant/data/plants_data_managing.dart';
import 'package:plant/domain/add_sell_post_data.dart';
import 'package:plant/screens/details/details_screen.dart';
import 'package:plant/screens/home/components/title_with_more_button.dart';

class RecommendPlants extends StatefulWidget {
  const RecommendPlants({super.key});
  @override
  State<RecommendPlants> createState() => _RecommendPlantsState();
}

class _RecommendPlantsState extends State<RecommendPlants> {
  PlantsDataManagement plantsDataManagement = PlantsDataManagement();
  List<SellPostsData> recommendedData = [];
  bool _clickedMore = false;
  Future<bool> assignList() async {
    recommendedData = await plantsDataManagement.getPlantsInfo();
    if (recommendedData.isEmpty) {
      return true;
    }
    return false;
  }

  List<Widget> getSellPosts(bool _isItColumn) {
    if (_isItColumn) {
      List<Widget> tempList = [];
      for (int i = 0; i < recommendedData.length; i += 2) {
        Widget firstCard = RecommendPlantCard(
          image: recommendedData[i].plantImage,
          title: recommendedData[i].plantName,
          country: recommendedData[i].division,
          price: recommendedData[i].price,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  plantName: recommendedData[i].plantName,
                  date: recommendedData[i].date,
                  price: recommendedData[i].price,
                  note: recommendedData[i].note,
                  division: recommendedData[i].division,
                  sellerID: recommendedData[i].sellerID,
                  sellerName: recommendedData[i].sellerName,
                  plantImage: recommendedData[i].plantImage,
                  totalPlants: recommendedData[i].totalPlants,
                  district: recommendedData[i].district,
                  soldPlants: recommendedData[i].soldPlants,
                  upzilla: recommendedData[i].upzilla,
                  location: recommendedData[i].location,
                  plantId: recommendedData[i].plantID,
                  isNote: false,
                ),
              ),
            );
          },
        );

        Widget? secondCard;
        if (i + 1 < recommendedData.length) {
          secondCard = RecommendPlantCard(
            image: recommendedData[i + 1].plantImage,
            title: recommendedData[i + 1].plantName,
            country: recommendedData[i + 1].division,
            price: recommendedData[i + 1].price,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    plantName: recommendedData[i].plantName,
                    date: recommendedData[i].date,
                    price: recommendedData[i].price,
                    note: recommendedData[i].note,
                    division: recommendedData[i].division,
                    sellerID: recommendedData[i].sellerID,
                    sellerName: recommendedData[i].sellerName,
                    plantImage: recommendedData[i].plantImage,
                    totalPlants: recommendedData[i].totalPlants,
                    district: recommendedData[i].district,
                    soldPlants: recommendedData[i].soldPlants,
                    upzilla: recommendedData[i].upzilla,
                    location: recommendedData[i].location,
                    plantId: recommendedData[i].plantID,
                    isNote: false,
                  ),
                ),
              );
            },
          );
        }

        tempList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [firstCard, if (secondCard != null) secondCard],
        ));
      }
      return tempList;
    }
    List<Widget> tempList = [];
    for (int i = 0; i < recommendedData.length; i++) {
      tempList.add(RecommendPlantCard(
        image: recommendedData[i].plantImage,
        title: recommendedData[i].plantName,
        country: recommendedData[i].division,
        price: recommendedData[i].price,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                plantName: recommendedData[i].plantName,
                date: recommendedData[i].date,
                price: recommendedData[i].price,
                note: recommendedData[i].note,
                division: recommendedData[i].division,
                sellerID: recommendedData[i].sellerID,
                sellerName: recommendedData[i].sellerName,
                plantImage: recommendedData[i].plantImage,
                totalPlants: recommendedData[i].totalPlants,
                district: recommendedData[i].district,
                soldPlants: recommendedData[i].soldPlants,
                upzilla: recommendedData[i].upzilla,
                location: recommendedData[i].location,
                plantId: recommendedData[i].plantID,
                isNote: false,
              ),
            ),
          );
        },
      ));
    }
    return tempList;
  }

  Widget getDirectedSellPosts() {
    return _clickedMore
        ? Column(
            children: getSellPosts(_clickedMore),
          )
        : Row(
            children: getSellPosts(_clickedMore),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TitleWithMoreButton(
          title: 'Recommended',
          text: _clickedMore ? 'Less' : 'More',
          onPressed: () {
            setState(() {
              if (_clickedMore) {
                _clickedMore = false;
              } else {
                _clickedMore = true;
              }
            });
          },
        ),
        SingleChildScrollView(
          scrollDirection: _clickedMore ? Axis.vertical : Axis.horizontal,
          child: FutureBuilder<bool>(
            future: assignList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return snapshot.data == true
                      ? CircularProgressIndicator()
                      : getDirectedSellPosts();
                }
              }
            },
          ),
        )
      ],
    );
  }
}

class RecommendPlantCard extends StatelessWidget {
  final String image, title, country;
  final double price;
  final VoidCallback onPressed;

  const RecommendPlantCard({
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: precacheImage(NetworkImage(image), context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: Image.network(image),
                  );
                }
              },
            ),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Text(
                      'tk $price',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      '$title'.toUpperCase(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: kTextColor.withOpacity(0.5),
                          fontWeight: FontWeight.normal,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      '$country'.toUpperCase(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWithCustomUnderline extends StatelessWidget {
  final String title;

  const TitleWithCustomUnderline({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
