import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavIcon extends StatelessWidget {
  NavIcon({Key? key, required this.image, required this.label})
      : super(key: key);
  String image;
  String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: SvgPicture.asset(
        image,
        semanticsLabel: label,
        fit: BoxFit.scaleDown,
        width: 50,
        height: 50,
        color: Color(0xFF00B4D8),
      ),
    );
  }
}
