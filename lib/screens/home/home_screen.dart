import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant/constants.dart';
import 'package:plant/data/plants_data_managing.dart';
import 'package:plant/screens/cart/cart_screen.dart';
import 'package:plant/screens/home/components/body.dart';
import 'package:plant/screens/post/post_screen.dart';
import 'package:plant/screens/sell/add_sell.dart';

import '../../domain/users.dart';
import '../account/account_screen.dart';

class HomeScreen extends StatefulWidget {
  static const id = "Home";
  static String username = "usernmae";
  static Users user = Users(
      userDateOfBirth: "some",
      phoneNumber: "some",
      email: "some",
      fullName: "some",
      userName: "some",
      userImage: "some");
  Users users;
  HomeScreen({super.key, required this.users});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentItem = 0;
  PlantsDataManagement plantsDataManagement = PlantsDataManagement();
  final pages = [
    Body(),
    Post(),
    CartScreen(),
    AddSell(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: pages[_currentItem],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -10),
              blurRadius: 35,
              color: kPrimaryColor.withOpacity(0.1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentItem,
          selectedItemColor: Colors.teal[800],
          type: BottomNavigationBarType.shifting,
          unselectedFontSize: 12.0,
          unselectedItemColor: Colors.black,
          selectedFontSize: 18.0,
          iconSize: 36,
          items: [
            bottomNavigationBarItem(
              icon: Icons.home,
              Name: "Home",
            ),
            bottomNavigationBarItem(
              icon: Icons.description,
              Name: "Post",
            ),
            bottomNavigationBarItem(
              icon: Icons.shopping_cart,
              Name: "Cart",
            ),
            bottomNavigationBarItem(
              icon: Icons.add_box_outlined,
              Name: "Sell",
            ),
            bottomNavigationBarItem(
              icon: Icons.person,
              Name: "Account",
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentItem = index;
            });
          },
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      icon: SvgPicture.asset('assets/icons/menu.svg'),
      onPressed: () {},
    ),
  );
}

BottomNavigationBarItem bottomNavigationBarItem(
    {String? Name, IconData? icon}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: Name!,
    backgroundColor: Colors.white,
  );
}
