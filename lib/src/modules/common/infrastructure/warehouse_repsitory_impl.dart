import 'package:injectable/injectable.dart';
import 'package:localdb/src/modules/common/domain/interfaces/warehouse_repository.dart';
import 'package:localdb/src/modules/common/domain/warehouse.dart';
import 'package:localdb/src/modules/common/domain/warehouse_fromto.dart';
import 'package:localdb/src/modules/core/local/dao/wh_from_to_dao.dart';
import 'package:localdb/src/modules/core/local/model/wh.dart';
import 'package:localdb/src/modules/core/local/dao/wh_dao.dart';

@Injectable(as: IWarehouseRepository)
class WarehouseRepositoryImpl implements IWarehouseRepository {
  final WarehouseDao whDao;
  final WareHouseFromToDao whFtDao;

  const WarehouseRepositoryImpl(this.whDao, this.whFtDao);

  @override
  Future<List<int>> addAll(List<Warehouse> warehouses) {
    final models = warehouses.map((e) => e.toModels());
    return whDao.addWarehouse(models);
  }

  @override
  Future<int> addFromTo(WareHouseFromToLink fromTo) {
    final from = fromTo.from;
    final to = fromTo.to;
    return whFtDao.insert(from, to);
  }

  @override
  Future<List<Warehouse>> getFromSource() async {
    final data = await whFtDao.getFrom();
    final result = data.map((e) => e.toEntity()).toList();
    return result;
  }

  @override
  Future<List<Warehouse>> getToSourceByFromId(int fromId) async {
    final data = await whFtDao.getToByFromId(fromId);
    final result = data.map((e) => e.toEntity()).toList();
    return result;
  }
}
