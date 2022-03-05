import 'package:financy/commands/item_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/enums/item_type.dart';
import '../../../models/enums/time_frame.dart';

class ListViewAppBar extends StatefulWidget {
  const ListViewAppBar({Key? key}) : super(key: key);

  @override
  State<ListViewAppBar> createState() => _ListViewAppBarState();
}

class _ListViewAppBarState extends State<ListViewAppBar> {
  Map<ItemType, String> itemTypeToString = {
    ItemType.undefined: 'Everything',
    ItemType.income: 'Incomes',
    ItemType.expense: 'Expenses'
  };
  Map<TimeFrame, String> timeFrameToString = {
    TimeFrame.all: 'All time',
    TimeFrame.today: 'Last day',
    TimeFrame.lastWeek: 'Last week',
    TimeFrame.lastMonth: 'Last month'
  };

  List<PopupMenuItem> itemBuilderFromMap(Map<dynamic, String> map) {
    List<PopupMenuItem> result = [];
    for (var e in map.keys) {
      result.add(
        PopupMenuItem(
          child: Text(map[e]!),
          value: e,
          textStyle: const TextStyle(color: Color(0xffeeeeee)),
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      backgroundColor: Theme.of(context).colorScheme.background,
      floating: true,
      snap: true,
      toolbarHeight: 0,
      collapsedHeight: 0,
      flexibleSpace: SafeArea(
        child: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: const EdgeInsets.only(top: 150),
          expandedTitleScale: 2,
          title: Center(
            child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: Text('${itemTypeToString[context.watch<ItemNotifier>().selectedItemType]}')),
          ),
          background: Container(
            margin: const EdgeInsets.only(top: 150, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text('${timeFrameToString[context.watch<ItemNotifier>().selectedTimeFrame]}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w100,
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                      onSelected: (item) {
                        final ItemNotifier notifier = Provider.of<ItemNotifier>(context, listen: false);
                        notifier.selectedTimeFrame = item as TimeFrame;
                        notifier.get(timeFrame: notifier.selectedTimeFrame, itemType: notifier.selectedItemType);
                      },
                      icon: const Icon(
                        Icons.access_time,
                        size: 35,
                      ),
                      itemBuilder: (BuildContext context) {
                        return itemBuilderFromMap(timeFrameToString);
                      },
                    ),
                    PopupMenuButton(
                      onSelected: (item) {
                        final ItemNotifier notifier = Provider.of<ItemNotifier>(context, listen: false);
                        notifier.selectedItemType = item as ItemType;
                        notifier.get(timeFrame: notifier.selectedTimeFrame, itemType: notifier.selectedItemType);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 35,
                      ),
                      itemBuilder: (BuildContext context) {
                        return itemBuilderFromMap(itemTypeToString);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
