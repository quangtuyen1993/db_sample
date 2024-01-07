

import 'package:localdb/src/modules/common/domain/warehouse.dart';
import 'package:localdb/src/modules/common/domain/warehouse_fromto.dart';

abstract class IWarehouseRepository {
  Future<List<int>> addAll(List<Warehouse> warehouse);
  Future<int> addFromTo(WareHouseFromToContract fromTo);

}