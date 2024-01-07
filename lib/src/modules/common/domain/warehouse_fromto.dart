import 'warehouse.dart';

abstract interface class WareHouseFromTo {
  Warehouse get from;

  Warehouse get to;

  const factory WareHouseFromTo.create({
    required Warehouse from,
    required Warehouse to,
  }) = WareHouseFromToEntity;
}

abstract class WareHouseFromToLink {
  int get from;

  int get to;
}

class WareHouseFromToEntity implements WareHouseFromTo {
  @override
  final Warehouse from;
  @override
  final Warehouse to;

  const WareHouseFromToEntity({required this.from, required this.to});
}

class WareHouseFromToLinkEntity implements WareHouseFromToLink {
  @override
  final int from;
  @override
  final int to;

  const WareHouseFromToLinkEntity(this.from, this.to);
}
