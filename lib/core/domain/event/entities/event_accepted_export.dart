import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_accepted_export.freezed.dart';
part 'event_accepted_export.g.dart';

@freezed
class EventAcceptedExport with _$EventAcceptedExport {
  factory EventAcceptedExport({
    String? id,
    String? name,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phone,
    String? amount,
    String? currency,
    double? ticketCount,
    String? ticketType,
    String? ticketDiscount,
    String? ticketDiscountAmount,
    String? imageAvatar,
    DateTime? checkinDate,
  }) = _EventAcceptedExport;

  factory EventAcceptedExport.fromJson(Map<String, dynamic> json) =>
      _$EventAcceptedExportFromJson(json);
}
