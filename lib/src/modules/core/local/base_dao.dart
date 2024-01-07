import 'package:isar/isar.dart';

abstract class BaseDao<T> {
  final Isar isar;
  const BaseDao(this.isar);
  IsarCollection<T> get collection;
}
