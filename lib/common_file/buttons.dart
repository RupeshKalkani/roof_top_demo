// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  SubmitButton({
    Key? key,
    required this.title,
    this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  Color bgColor = Colors.deepPurpleAccent;
  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 55,
      width: width ?? Get.width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(60),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
