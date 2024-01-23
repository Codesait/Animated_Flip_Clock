import 'package:flutter/material.dart';

///* [fullWidth] is used this for getting device full width
double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

///* [fullHeight] is used this for getting device full height
double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

///* [getContainerHeight] should be used for a scaffold body minus
///*appbar height in order to get the accurate body height
double getContainerHeight(BuildContext context) {
  final mq = MediaQuery.of(context);
  return mq.size.height - AppBar().preferredSize.height - mq.padding.vertical;
}
