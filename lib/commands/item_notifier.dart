import 'package:financy/services/item_service.dart';
import 'package:flutter/material.dart';

import '../models/enums/item_type.dart';
import '../models/enums/time_frame.dart';
import '../models/item.dart';

class ItemNotifier extends ChangeNotifier {
  List<Item> itemList = [];
  ItemType selectedItemType = ItemType.undefined;
  TimeFrame selectedTimeFrame = TimeFrame.all;

  ItemNotifier() {
    get();
  }

  void get({TimeFrame? timeFrame, ItemType? itemType, String? sortBy}) async {
    itemList = await ItemService.findAllWithinTimeFrame(timeFrame ?? TimeFrame.all, itemType, sortBy);
    notifyListeners();
  }

  void insert(Item item) async {
    await ItemService.insert(item);
  }

  void insertAndGet(Item item, {TimeFrame? timeFrame, ItemType? itemType, String? sortBy}) {
    insert(item);
    get(timeFrame: timeFrame, itemType: itemType, sortBy: sortBy);
  }

  void delete(int id) async {
    await ItemService.delete(id);
  }

  void deleteAndGet(int id, {TimeFrame? timeFrame, ItemType? itemType, String? sortBy}) {
    delete(id);
    get(timeFrame: timeFrame, itemType: itemType, sortBy: sortBy);
  }
}
