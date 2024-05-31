import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_accepted_export.freezed.dart';
part 'event_accepted_export.g.dart';

@freezed
class EventAcceptedExport with _$EventAcceptedExport {
  factory EventAcceptedExport({
    String? id,
    bool? active,
    String? ticketType,
    DateTime? checkinDate,
    String? buyerId,
    String? buyerEmail,
    String? buyerName,
    String? buyerAvatar,
    String? buyerUsername,
    List<String>? buyerWallets,
    String? assigneeAvatar,
    String? assigneeName,
    String? assigneeFirstName,
    String? assigneeLastName,
    String? assigneeUsername,
    String? assigneeEmail,
    String? assigneePhone,
    List<String>? assigneeWallets,
    String? paymentId,
    String? ticketPrice,
    String? currency,
    String? paymentAmount,
    String? discountAmount,
    String? discount,
    double? ticketCount,
  }) = _EventAcceptedExport;

  factory EventAcceptedExport.fromJson(Map<String, dynamic> json) =>
      _$EventAcceptedExportFromJson(json);
}
