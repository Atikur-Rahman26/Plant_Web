import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant/constants.dart';

class IconCard extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  const IconCard({required this.image, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 22,
            color: kPrimaryColor.withOpacity(0.3),
          ),
          BoxShadow(
            offset: Offset(-15, -15),
            blurRadius: 20,
            color: kPrimaryColor.withOpacity(0.3),
          ),
        ],
      ),
      child: MaterialButton(
        height: 62,
        minWidth: 62,
        onPressed: onPressed,
        child: SvgPicture.asset(
          image,
        ),
      ),
    );
  }
}
