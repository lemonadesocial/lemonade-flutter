import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchasable_item.freezed.dart';
part 'purchasable_item.g.dart';

@freezed
class PurchasableItem with _$PurchasableItem {
  factory PurchasableItem({
    required String id,
    required int count,
  }) = _PurchasableItem;

  factory PurchasableItem.fromJson(Map<String, dynamic> json) =>
      _$PurchasableItemFromJson(json);
}
