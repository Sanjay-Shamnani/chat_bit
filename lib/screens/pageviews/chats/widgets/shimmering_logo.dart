import 'package:chat_bit/utils/universal_variables.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Shimmer.fromColors(
          child: Image.asset("assets/app_logo.jpg"),
          baseColor: UniversalVariables.blackColor,
          highlightColor: Colors.red),
    );
  }
}
