part of 'wh_cubit.dart';

@freezed
class WareHouseState with _$WareHouseState {
  const factory WareHouseState({
    @Default([]) List<Warehouse> sourceFrom,
    @Default([]) List<Warehouse> sourceTo,
    Warehouse? from,
    Warehouse? to,
  }) = _WareHouseState;
}
