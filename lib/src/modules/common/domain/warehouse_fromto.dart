import 'warehouse.dart';

abstract class WareHouseFromTo {
  Warehouse get from;

  List<Warehouse> get to;
}

abstract class WareHouseFromToContract {
  int get from;

  List<int> get to;
}

class WareHouseFromToContractEntity implements WareHouseFromToContract {
  @override
  final int from;
  @override
  final List<int> to;
  const WareHouseFromToContractEntity(this.from, this.to);
}
