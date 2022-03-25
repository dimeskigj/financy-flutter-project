import 'package:financy/models/enums/time_frame.dart';
import 'package:financy/models/item_db.dart';

import '../models/enums/item_type.dart';
import '../models/item.dart';

class ItemService {
  ItemService._internal();

  static final ItemService _instance = ItemService._internal();

  factory() {
    return _instance;
  }

  static Future<List<Item>> findAll([ItemType? itemType, String? sortBy]) async {
    if (itemType == null || itemType == ItemType.undefined) {
      return await ItemDatabase.findAll();
    } else {
      return await ItemDatabase.findAllBy(itemType, sortBy: sortBy);
    }
  }

  static Future<int> insert(Item item) async {
    return await ItemDatabase.insertItem(item);
  }

  static Future<int> delete(int id) async {
    return await ItemDatabase.delete(id);
  }

  static Future<List<Item>> findAllWithinTimeFrame(TimeFrame timeFrame, [ItemType? itemType, String? sortBy]) async {
    //I'm not that good with queries 😓
    List<Item> unfiltered = await findAll(itemType, sortBy);
    if (timeFrame == TimeFrame.all) return unfiltered;
    int daysToSubtract = timeFrame == TimeFrame.today
        ? 1
        : timeFrame == TimeFrame.lastWeek
            ? 7
            : 30;
    unfiltered.removeWhere((element) => element.dateTime.isBefore(DateTime.now().subtract(Duration(days: daysToSubtract))));
    return unfiltered;
  }
}
