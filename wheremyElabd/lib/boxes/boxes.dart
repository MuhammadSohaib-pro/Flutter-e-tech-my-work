

import 'package:hive/hive.dart';
import 'package:wheremyelabd/models/storage_model.dart';

class Boxes{

  static Box<StorageModel> getData() => Hive.box<StorageModel>('StoragePlace');
  static Box<ItemModel> getItemBox() => Hive.box<ItemModel>('ItemModel');
  static Box<editprofile> getEditprofile() => Hive.box<editprofile>('editprofile');
}