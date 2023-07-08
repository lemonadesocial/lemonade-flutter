import 'package:app/core/domain/common/common_enums.dart';
import 'package:app/core/domain/token/token_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'watch_orders_input.freezed.dart';
part 'watch_orders_input.g.dart';

@freezed
class OrderWhereComplex with _$OrderWhereComplex {
  const factory OrderWhereComplex({
    @JsonKey(name: 'maker_in', includeIfNull: false) List<String>? makerIn,
    @JsonKey(name: 'open_eq', includeIfNull: false) bool? openEq,
    @JsonKey(name: 'taker_exists', includeIfNull: false) bool? takerExists,
  }) = _OrderWhereComplex; 

  factory OrderWhereComplex.fromJson(Map<String, dynamic> json) => _$OrderWhereComplexFromJson(json);
}

@freezed
class OrderSort with _$OrderSort {
  const factory OrderSort({
    @JsonKey(includeIfNull: false) OrderSortBy? by,
    @JsonKey(includeIfNull: false) SortDirection? direction ,
  }) = _OrderSort; 

  factory OrderSort.fromJson(Map<String, dynamic> json) => _$OrderSortFromJson(json);
}

@freezed
class WatchOrdersInput with _$WatchOrdersInput {

  @JsonSerializable(explicitToJson: true)
  const factory WatchOrdersInput({
    @JsonKey(includeIfNull: false) OrderWhereComplex? where,
    @JsonKey(includeIfNull: false) OrderSort? sort,
    @JsonKey(includeIfNull: false) bool? query,
    @JsonKey(includeIfNull: false) int? skip,
    @JsonKey(includeIfNull: false) int? limit,
  }) = _WatchOrdersInput;

  factory WatchOrdersInput.fromJson(Map<String, dynamic> json) => _$WatchOrdersInputFromJson(json);
}

