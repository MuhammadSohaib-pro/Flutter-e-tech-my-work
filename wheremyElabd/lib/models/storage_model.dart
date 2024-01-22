import 'package:hive/hive.dart';

part 'storage_model.g.dart';
//part 'item_model.g.dart';
@HiveType(typeId: 0)
class StorageModel extends HiveObject {
  @HiveField(0)
  final String storageplacename;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final int itemcount;

  @HiveField(3)
  final List<ItemModel> items;

  StorageModel({
    required this.storageplacename,
    required this.description,
    required this.itemcount,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'storageplacename': storageplacename,
      'description': description,
      'itemcount': itemcount,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

@HiveType(typeId: 1)
class ItemModel extends HiveObject {
  @HiveField(0)
  String itemName;

  @HiveField(1)
  String itemDescription;

  @HiveField(2)
  String imagePath;

  @HiveField(3)
  final String time;

  ItemModel({
    required this.imagePath,
    required this.itemName,
    required this.itemDescription,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemDescription': itemDescription,
      'imagePath': imagePath,
      'time': time,
    };
  }
}

@HiveType(typeId: 2)
class editprofile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String country;

  @HiveField(3)
  String description;

  @HiveField(4)
  String imagePath;

  editprofile({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.country,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'country': country,
      'description': description,
      'imagePath': imagePath,
    };
  }
}
