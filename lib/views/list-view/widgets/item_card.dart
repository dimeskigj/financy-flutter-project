import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item _item;

  const ItemCard(this._item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: SizedBox(
        height: 100,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_item.amount.toString()),
                Column(
                  children: [Text(_item.title), Text(_item.dateTime.toIso8601String())],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
