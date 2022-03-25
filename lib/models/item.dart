import 'enums/item_type.dart';

class Item {
  int? id;
  final String title, description;
  final DateTime dateTime;
  final double amount, longitude, latitude;
  final ItemType itemType;

  Item(
      {this.id,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.amount,
      required this.longitude,
      required this.latitude,
      required this.itemType});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toString(),
      'amount': amount,
      'longitude': longitude,
      'latitude': latitude,
      'itemType': itemType.index
    };
  }

  @override
  String toString() {
    return 'Item{id: $id, title: $title, description: $description, dateTime: ${dateTime.toString()}, amount: $amount, longitude: $longitude, latitude: $latitude, itemType: ${itemType.index}}';
  }
}
