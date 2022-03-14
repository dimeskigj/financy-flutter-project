import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsSubItem extends StatelessWidget {
  final String header, text;
  final TextStyle onHeader, onText;

  const DetailsSubItem({Key? key, required this.header, required this.text, required this.onHeader, required this.onText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            header,
            style: onHeader,
          ),
          Text(
            text,
            style: onText,
          ),
        ],
      ),
    );
  }
}
