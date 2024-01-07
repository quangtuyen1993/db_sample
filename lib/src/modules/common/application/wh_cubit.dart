import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:localdb/src/modules/common/domain/warehouse.dart';

import 'wh_worker_delegate.dart';

part 'wh_state.dart';

part 'wh_cubit.freezed.dart';

enum Mode { to, fromTo }

@injectable
class WareHouseCubit extends Cubit<WareHouseState> {
  final WareHouseDelegate delegate;

  Mode get mode => delegate.mode;

  WareHouseCubit(@factoryParam this.delegate) : super(const WareHouseState()) {
    init();
  }

  init() async {
    final fromSource = await initFromSource();
    final toSource = await initToSource();
    emit(state.copyWith(
      sourceFrom: fromSource,
      sourceTo: toSource,
    ));
  }

  selectedWhFrom(Warehouse? from) async {
    ///loading
    final newFromSource =
        from == null ? <Warehouse>[] : await getToFromFromId(from.id);

    /// emit loaded
    emit(state.copyWith(from: from, sourceTo: newFromSource, to: null));
  }

  selectedWhTo(Warehouse? to) async {
    emit(state.copyWith(to: to));
  }

  Future<List<Warehouse>> initFromSource() {
    return delegate.initFromSource();
  }

  Future<List<Warehouse>> initToSource() {
    return delegate.initToSource();
  }

  Future<List<Warehouse>> getToFromFromId(int id) {
    return delegate.getToFromFromId(id);
  }
}
