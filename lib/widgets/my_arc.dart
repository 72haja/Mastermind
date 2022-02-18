import 'package:flutter/material.dart';

class MyArc extends StatelessWidget {
  final Color color;

  const MyArc({Key? key, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 1,
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
      ),
    );
  }
}
