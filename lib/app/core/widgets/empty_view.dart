import 'package:tracking/app/core/utils/font_utils.dart';
import 'package:flutter/material.dart';


class EmptyView extends StatelessWidget {
  final String message;
  const EmptyView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          message,
          style: FontUtils.nexaTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
