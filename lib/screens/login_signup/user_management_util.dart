import 'package:flutter/material.dart';

import '../../constants.dart';

EdgeInsets containerPadding = const EdgeInsets.only(
  left: 15,
  right: 15,
  top: 5,
);

EdgeInsets containerMargin = const EdgeInsets.only(
  left: 10,
  right: 10,
  bottom: 10,
  top: 10,
);
BoxDecoration containerBoxDecoration = const BoxDecoration(
  color: kCartBackgroundColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30),
    bottomRight: Radius.circular(30),
  ),
);
