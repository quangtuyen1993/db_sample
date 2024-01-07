import 'dart:io';

import 'package:isar/isar.dart';
import 'package:localdb/src/modules/common/domain/warehouse.dart';

part 'wh.g.dart';

@collection
class WareHouseModel {
  Id? id;
  late String name;
}

extension WarehouseX on Warehouse {
  WareHouseModel toModels() {
    return WareHouseModel()
      ..id = id
      ..name = name;
  }
}

@collection
class WareHouseFromTosModel {
  Id? id;
  final from = IsarLink<WareHouseModel>();
  final to = IsarLinks<WareHouseModel>();
}
