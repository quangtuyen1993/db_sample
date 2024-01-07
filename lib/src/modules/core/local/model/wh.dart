import 'package:isar/isar.dart';
import 'package:localdb/src/modules/common/domain/warehouse.dart';

part 'wh.g.dart';

@collection
class WareHouseModel {
  Id? id;
  String? name;
}

extension WarehouseModelX on WareHouseModel {
  Warehouse toEntity() {
    return WareHouseEntity(id: id ?? -1, name: name??'');
  }
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
  Id get isarId => int.tryParse('$fromId$toId') ?? -1;
  int get fromId => from.value?.id ?? -1;
  int get toId => to.value?.id ?? -1;
  final from = IsarLink<WareHouseModel>();
  final to = IsarLink<WareHouseModel>();
}

