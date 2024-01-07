import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'model/wh.dart';

class AppDatabase {
  final Isar isar;

  const AppDatabase._(this.isar);

  static Future<AppDatabase> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [WareHouseModelSchema, WareHouseFromTosModelSchema],
      directory: dir.path,
    );
    return AppDatabase._(isar);
  }
}
