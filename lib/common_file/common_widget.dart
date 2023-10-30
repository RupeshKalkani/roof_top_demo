import 'package:flutter/material.dart';
import 'package:roof_top_demo/common_file/style.dart';

import 'color.dart';

class ErrorText extends StatelessWidget {
  final String? text;

  const ErrorText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((text ?? '').isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 4),
        Text(
          text ?? '',
          style: styleW400S12.copyWith(color: AppColor.red),
        ),
      ],
    );
  }
}