import 'package:isar/isar.dart';
import 'package:localdb/src/modules/common/domain/warehouse.dart';
import 'package:localdb/src/modules/common/domain/warehouse_fromto.dart';

part 'wh.g.dart';

@collection
class WareHouseModel {
  Id? id;
  late String name;
}

extension WarehouseModelX on WareHouseModel {
  Warehouse toEntity() {
    return WareHouseEntity(id: id ?? -1, name: name);
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
  String get id => '${from.value?.id}${to.value?.id}';

  Id get isarId => fastHash(id);

  int get fromId => from.value?.id ?? -1;
  final from = IsarLink<WareHouseModel>();
  final to = IsarLink<WareHouseModel>();
}

int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

extension WareHouseFromTosModelX on WareHouseFromTosModel {
  WareHouseFromTo toEntity() {
    final fromEntity = from.value!.toEntity();
    final toEntity = to.value!.toEntity();
    return WareHouseFromTo.create(from: fromEntity, to: toEntity);
  }
}
