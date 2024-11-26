import 'package:flutter/material.dart';

class BottomBoxWidget extends StatelessWidget {
  Widget? child;
  BottomBoxWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      
      child: child,
    );
  }
}
