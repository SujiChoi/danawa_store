import 'package:danawa_store2/util/AppColor.dart';
import 'package:flutter/material.dart';


class SearchBar extends StatelessWidget {
  final String title;
  SearchBar({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
          color: AppColor.placeholderBg,
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search,color: Colors.black,),
            hintText: title,
            hintStyle: TextStyle(
              color: AppColor.placeholder,
              fontSize: 18,
            ),
            // contentPadding: const EdgeInsets.only(
            //   top: 17,
            // ),
          ),
        ),
      ),
    );
  }
}