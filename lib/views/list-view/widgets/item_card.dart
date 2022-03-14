import 'package:financy/commands/item_notifier.dart';
import 'package:financy/models/enums/item_type.dart';
import 'package:financy/views/details/details_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/item.dart';

class ItemCard extends StatelessWidget {
  final Item _item;

  const ItemCard(this._item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        final ItemNotifier notifier = Provider.of<ItemNotifier>(context, listen: false);
        notifier.delete(_item.id!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          content: Text(
            'Deleted ${_item.title}',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          action: SnackBarAction(
            onPressed: () {
              notifier.insert(_item);
              notifier.get(timeFrame: notifier.selectedTimeFrame, itemType: notifier.selectedItemType);
            },
            label: 'UNDO',
          ),
        ));
      },
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => DetailsScaffold(item: _item)));
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: SizedBox(
            height: 125,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _item.amount.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: _item.itemType == ItemType.expense
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.inversePrimary),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        _item.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy kk:mm').format(_item.dateTime),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
