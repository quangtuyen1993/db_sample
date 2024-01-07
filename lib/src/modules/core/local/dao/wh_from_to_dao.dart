import 'package:isar/isar.dart';

import 'package:localdb/src/modules/core/local/base_dao.dart';
import 'package:localdb/src/modules/core/local/model/wh.dart';
import 'package:localdb/src/modules/utils/collection_x.dart';

class WareHouseFromToDao extends BaseDao<WareHouseFromTosModel> {
  const WareHouseFromToDao(super.isar);

  @override
  IsarCollection<WareHouseFromTosModel> get collection =>
      isar.wareHouseFromTosModels;

  Future<int> insert(int fromId, int toId) {
    return isar.writeTxn(() async {
      final from = WareHouseModel()..id = fromId;
      final to = WareHouseModel()..id = toId;
      final data = WareHouseFromTosModel()
        ..from.value = from
        ..to.value = to;
      final result = await collection.put(data);
      await data.to.save();
      await data.from.save();
      return result;
    });
  }

  Future<List<WareHouseModel>> getFrom() async {
    final from = await isar.txn(
      collection.where().sortByFromId().distinctByFromId().findAll,
    );
    final data = from.mapNotNull<WareHouseModel>((e) => e.from.value).toList();
    return data;
  }

  Future<List<WareHouseModel>> getToByFromId(int fromId) async {
    final to = await isar.txn(
      collection.filter().fromIdEqualTo(fromId).sortByFromId().findAll,
    );
    final data = to.mapNotNull((e) => e.to.value).toList();
    return data;
  }
}
