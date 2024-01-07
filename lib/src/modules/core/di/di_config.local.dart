import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:localdb/src/modules/core/local/app_database.dart';
import 'package:localdb/src/modules/core/local/dao/wh_dao.dart';
import 'package:localdb/src/modules/core/local/dao/wh_from_to_dao.dart';

import 'di_utils.dart';

@module
abstract class LocalModule {
  @singleton
  @preResolve
  Future<AppDatabase> get db => AppDatabase.create();

  @lazySingleton
  Isar get isar => getIt<AppDatabase>().isar;

  @injectable
  WarehouseDao get warehouseDao => WarehouseDao(getIt<Isar>());

  @injectable
  WareHouseFromToDao get warehouseFromTODao => WareHouseFromToDao(getIt<Isar>());
}
