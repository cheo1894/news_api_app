import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  String? text;
  Widget? icon;
  void Function()? onPressed;
  NavIcon({super.key, this.text, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              child: icon,
            ),
            Text(text ?? '', style: TextStyle(fontSize: 12),)
          ],
        ));
  }
}
