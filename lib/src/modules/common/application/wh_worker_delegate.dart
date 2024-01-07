import 'package:injectable/injectable.dart';
import 'package:localdb/src/modules/common/application/wh_cubit.dart';
import 'package:localdb/src/modules/common/domain/interfaces/warehouse_repository.dart';

import '../domain/warehouse.dart';

mixin WareHouseDelegate {
  Mode get mode;

  Future<List<Warehouse>> initFromSource();

  Future<List<Warehouse>> initToSource();

  Future<List<Warehouse>> getToFromFromId(int id);
}


@injectable
class WareHouseFromToDelegateImpl with WareHouseDelegate {
  const WareHouseFromToDelegateImpl(this.warehouseRepository);

  final IWarehouseRepository warehouseRepository;

  @override
  Mode get mode => Mode.fromTo;

  @override
  Future<List<Warehouse>> getToFromFromId(int id) {
    return warehouseRepository.getToSourceByFromId(id);
  }

  @override
  Future<List<Warehouse>> initFromSource() async {
    return warehouseRepository.getFromSource();
  }

  @override
  Future<List<Warehouse>> initToSource() {
    return Future.value([]);
  }
}
