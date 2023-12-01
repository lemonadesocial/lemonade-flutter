import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/presentation/pages/event/guest_event_detail_page/widgets/guest_event_poap_offer_item.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestEventPoapOffers extends StatelessWidget {
  GuestEventPoapOffers({
    super.key,
    required this.event,
  });

  final Event event;

  List<EventOffer> get eventPoapOffers => (event.offers ?? [])
      .where((offer) => offer.provider == OfferProvider.poap)
      .toList();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 229.w,
          child: FutureBuilder(
            future: getIt<TokenRepository>().tokens(
              input: GetTokenComplexInput(
                where: TokenWhereComplex(
                  contractIn: eventPoapOffers
                      .map((offer) => offer.providerId ?? '')
                      .toList(),
                  networkIn: eventPoapOffers
                      .map((offer) => offer.providerNetwork ?? '')
                      .toList(),
                  tokenIdEq: '0',
                ),
              ),
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SizedBox(
                  child: EmptyList(
                    emptyText: t.common.somethingWrong,
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  child: Loading.defaultLoading(context),
                );
              }

              if (!snapshot.hasData) {
                return SizedBox(
                  child: EmptyList(
                    emptyText: t.common.somethingWrong,
                  ),
                );
              }

              var tokens = snapshot.data?.fold((l) => [], (list) => list) ?? [];

              if (tokens.isEmpty) {
                return SizedBox(
                  child: EmptyList(
                    emptyText: t.common.somethingWrong,
                  ),
                );
              }

              if (eventPoapOffers.length == 1) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: GuestEventPoapOfferItem(
                    offer: eventPoapOffers.first,
                    token: tokens.firstOrNull,
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                  width: 315.w,
                  child: GuestEventPoapOfferItem(
                    offer: eventPoapOffers[index],
                    token: tokens.isNotEmpty && index <= tokens.length - 1
                        ? tokens[index]
                        : null,
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  width: Spacing.extraSmall,
                ),
                itemCount: eventPoapOffers.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
