import 'package:isar/isar.dart';
import 'package:localdb/src/modules/core/local/base_dao.dart';
import 'package:localdb/src/modules/core/local/model/wh.dart';

class WarehouseDao extends BaseDao<WareHouseModel> {
  WarehouseDao(super.isar);

  @override
  IsarCollection<WareHouseModel> get collection => super.isar.wareHouseModels;

  Future<List<int>> addWarehouse(Iterable<WareHouseModel> models) async {
    return isar.writeTxn(() async => await collection.putAll(models.toList()));
  }

}
