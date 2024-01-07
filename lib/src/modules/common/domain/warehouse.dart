abstract interface class Warehouse {
  int get id;

  String get name;

  factory Warehouse.create({required int id, String name}) = WareHouseEntity;
}

class WareHouseEntity implements Warehouse {
  @override
  final int id;
  @override
  final String name;

  const WareHouseEntity({required this.id, this.name=''});
}
