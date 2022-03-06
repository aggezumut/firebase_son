import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback? onPressed; // bunlar için construct gerek
  MyElevatedButton({required this.child, required this.color, required this.onPressed});
  //const MyElevatedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 300,
      height: 40,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(12)),
      child: TextButton(

        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
