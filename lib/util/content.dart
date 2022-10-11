import 'package:flutter/material.dart';

final String accom_image_path = 'https://outsider21.cafe24.com/tour_app/manager/accom/image/';
final String accom_room_image_path = 'https://outsider21.cafe24.com/tour_app/manager/accom/roomimage/';
final String rest_image_path = 'https://outsider21.cafe24.com/tour_app/manager/rest/image/';
final String rest_menu_image_path = 'https://outsider21.cafe24.com/tour_app/manager/rest/menuimage/';
final String massage_image_path = 'https://outsider21.cafe24.com/tour_app/manager/massage/image/';
final String massage_menu_image_path = 'https://outsider21.cafe24.com/tour_app/manager/massage/menuimage/';
final String nail_image_path = 'https://outsider21.cafe24.com/tour_app/manager/nail/image/';
final String nail_menu_image_path = 'https://outsider21.cafe24.com/tour_app/manager/nail/menuimage/';
final String barber_image_path = 'https://outsider21.cafe24.com/tour_app/manager/barber/image/';
final String barber_menu_image_path = 'https://outsider21.cafe24.com/tour_app/manager/barber/menuimage/';
final String tour_image_path = 'https://outsider21.cafe24.com/tour_app/manager/tour/image/';
final String tour_menu_image_path = 'https://outsider21.cafe24.com/tour_app/manager/tour/menuimage/';

final kHintTextStyle = TextStyle(
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final MainColor = Color(0xffFF1F319D);
final BackGroundColor = Colors.white;

final kBoxDecorationStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),

  // boxShadow: [
  //   BoxShadow(
  //     color: Colors.black12,
  //     blurRadius: 6.0,
  //     offset: Offset(0, 2),
  //   ),
  // ],
);

Widget addVerticalSpace(double height){
  return SizedBox(
      height:height
  );
}

Widget addHorizontalSpace(double width){
  return SizedBox(
      width:width
  );
}
