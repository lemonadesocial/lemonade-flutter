import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_enums.dart';
import 'package:app/core/domain/token/input/get_tokens_input.dart';
import 'package:app/core/domain/token/token_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_collectibles_section/widgets/add_more_collectible_card_widget.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_collectibles_section/widgets/collectible_card_widget.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/widgets/host_collectibles_section/widgets/empty_collectible_card_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class HostCollectiblesSection extends StatelessWidget {
  const HostCollectiblesSection({
    super.key,
    required this.event,
  });

  final Event event;

  List<EventOffer> get eventPoapOffers => (event.offers ?? [])
      .where((offer) => offer.provider == OfferProvider.poap)
      .toList();

  @override
  Widget build(BuildContext context) {
    if (eventPoapOffers.isEmpty) {
      return const EmptyCollectibleCardWidget();
    }
    return FutureBuilder(
      future: getIt<TokenRepository>().tokens(
        input: GetTokenComplexInput(
          where: TokenWhereComplex(
            contractIn:
                eventPoapOffers.map((offer) => offer.providerId ?? '').toList(),
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
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Spacing.xSmall,
            mainAxisSpacing: Spacing.xSmall,
            childAspectRatio: 1,
          ),
          itemCount: tokens.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const AddMoreCollectibleCardWidget();
            }
            final token = tokens.isNotEmpty && index - 1 <= tokens.length - 1
                ? tokens[index - 1]
                : null;
            return CollectibleCardWidget(token: token);
          },
        );
      },
    );
  }
}
