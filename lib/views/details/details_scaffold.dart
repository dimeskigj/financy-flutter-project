import 'package:financy/views/details/widgets/details_body.dart';
import 'package:flutter/material.dart';

import '../../models/item.dart';

class DetailsScaffold extends StatelessWidget {
  final Item item;

  const DetailsScaffold({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
        body: DetailsBody(item: item));
  }
}
