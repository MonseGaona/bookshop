import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final double radious;
  final void Function()? press;
  const TwoSideRoundedButton({
    super.key,
    required this.text,
    this.radious = 29,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.BlueDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radious),
            bottomRight: Radius.circular(radious),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
