import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_ticket_export.freezed.dart';
part 'event_ticket_export.g.dart';

@freezed
class EventTicketExport with _$EventTicketExport {
  factory EventTicketExport({
    String? id,
    bool? active,
    String? ticketType,
    DateTime? checkinDate,
    String? buyerId,
    String? buyerEmail,
    String? buyerName,
    String? buyerAvatar,
    String? buyerUsername,
    String? buyerFirstName,
    String? buyerLastName,
    String? buyerWallet,
    String? assigneeEmail,
    List<String>? assigneeWallets,
    String? paymentId,
    String? currency,
    String? paymentAmount,
    String? discountAmount,
    String? discountCode,
    bool? isAssigned,
    bool? isClaimed,
    bool? isIssued,
    String? issuedBy,
    String? paymentProvider,
    DateTime? purchaseDate,
    double? quantity,
    String? ticketCategory,
  }) = _EventAcceptedExport;

  factory EventTicketExport.fromJson(Map<String, dynamic> json) =>
      _$EventTicketExportFromJson(json);
}
