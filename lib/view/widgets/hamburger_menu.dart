import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 15,
      width: 40,
      color: Color.fromRGBO(37, 51, 52, 1),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            width: 25,
            height: 3,
            margin: EdgeInsets.only(right: 8),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
          ),
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 3,
            width: 40,
          ),
          SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 3,
            width: 27,
            margin: EdgeInsets.only(left: 7),
          ),
        ],
      ),
    );
  }
}
