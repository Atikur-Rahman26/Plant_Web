import 'package:flutter/material.dart';
import 'package:plant/constants.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});
  static int getCurrentIndex() => getCurrentIndex();

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentItem = 0;
  int getCurrentItem() {
    return _currentItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentItem,
        selectedItemColor: Colors.teal[800],
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
            icon: Icons.person,
            Name: "Account",
          ),
          bottomNavigationBarItem(
            icon: Icons.shopping_cart,
            Name: "Cart",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentItem = index;
          });
          if (index == 1) {
            // Navigator.pushNamed(context, Post.id);
          }
        },
      ),
    );
  }
}

BottomNavigationBarItem bottomNavigationBarItem(
    {String? Name, IconData? icon}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: Name!,
    backgroundColor: Colors.white,
  );
}
