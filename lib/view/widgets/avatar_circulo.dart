import 'package:flutter/material.dart';

class AvatarCirculo extends StatefulWidget {
  final String pathImagem;

  const AvatarCirculo({super.key, required this.pathImagem});

  @override
  State<AvatarCirculo> createState() => _AvatarCirculo();
}

class _AvatarCirculo extends State<AvatarCirculo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 30),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(widget.pathImagem),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
