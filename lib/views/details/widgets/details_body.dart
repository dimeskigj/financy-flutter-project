import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/item.dart';
import 'details_sub_item.dart';
import 'map_wrapper.dart';

class DetailsBody extends StatelessWidget {
  final Item item;

  const DetailsBody({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle _headerStyle = TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    );
    final TextStyle _textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: 22,
    );

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsSubItem(
                header: 'Title',
                text: item.title,
                onHeader: _headerStyle,
                onText: _textStyle,
              ),
              const Divider(
                thickness: 0.8,
              ),
              DetailsSubItem(
                header: 'Description',
                text: item.description,
                onHeader: _headerStyle,
                onText: _textStyle,
              ),
              const Divider(
                thickness: 0.8,
              ),
              DetailsSubItem(
                header: 'Time',
                text: DateFormat('dd/MM/yyyy kk:mm').format(item.dateTime),
                onHeader: _headerStyle,
                onText: _textStyle,
              ),
              const Divider(
                thickness: 0.8,
              ),
              DetailsSubItem(
                header: 'Amount',
                text: item.amount.toString(),
                onHeader: _headerStyle,
                onText: _textStyle,
              ),
              const Divider(
                thickness: 0.8,
              ),
              MapWrapper(latLng: LatLng(item.latitude, item.longitude)),
            ],
          ),
        ),
      ],
    );
  }
}
