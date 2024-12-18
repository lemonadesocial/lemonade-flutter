import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/entities/event_ticket.dart';
import 'package:app/core/domain/onboarding/onboarding_inputs.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/guest_application_page/widgets/guest_application_info_form.dart';
import 'package:app/core/presentation/pages/event/event_detail_page/host_event_detail_page/sub_pages/guest_application_page/widgets/guest_application_info_user_card.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';

class GuestApplicationInfoPage extends StatelessWidget {
  final Event? event;
  final EventTicket? eventTicket;

  const GuestApplicationInfoPage({
    super.key,
    this.event,
    this.eventTicket,
  });

  Future<User?> _getUserInfo() async {
    final response = await getIt<UserRepository>().getUserProfile(
      GetProfileInput(
        id: eventTicket?.assignedTo ?? '',
      ),
    );
    return response.fold(
      (l) => null,
      (r) => r,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      appBar: LemonAppBar(
        backgroundColor: LemonColor.atomicBlack,
        title: t.event.eventApproval.application,
      ),
      body: FutureBuilder(
        future: _getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Loading.defaultLoading(context));
          }
          final userInfo = snapshot.data;
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: GuestApplicationInfoUserCard(
                        userInfo: userInfo,
                      ),
                    ),
                    GuestApplicationInfoForm(
                      userInfo: userInfo,
                      event: event,
                      eventTicket: eventTicket,
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: Spacing.xLarge * 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
