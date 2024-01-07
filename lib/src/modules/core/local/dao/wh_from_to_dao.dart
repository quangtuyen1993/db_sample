import 'package:isar/isar.dart';
import 'package:localdb/src/modules/core/local/base_dao.dart';
import 'package:localdb/src/modules/core/local/model/wh.dart';

class WareHouseFromToDao extends BaseDao<WareHouseFromTosModel> {
  const WareHouseFromToDao(super.isar);

  @override
  IsarCollection<WareHouseFromTosModel> get collection =>
      isar.wareHouseFromTosModels;

  Future<int> insert(int fromId, List<int> to) {
    return isar.writeTxn(() async {
      final from = WareHouseModel()..id = fromId;
      final toList = to.map((e) {
        return WareHouseModel()..id = e;
      });
      final data = WareHouseFromTosModel()
        ..id = fromId
        ..from.value = from
        ..to.addAll(toList);
      final result = await collection.put(data);
      await data.to.save();
      await data.from.save();
      return result;
    });
  }
}
