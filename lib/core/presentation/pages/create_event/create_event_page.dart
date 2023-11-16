import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/gql/backend_gql_client.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/graphql/__generated__/create_event.req.gql.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:app/i18n/i18n.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateEventPage extends StatelessWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = getIt<BackendFerryClient>().client;

    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorScheme.primary,
        appBar: LemonAppBar(
          title: t.event.createEvent,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Spacing.medium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LemonTextField(
                      label: "Title*",
                      onChange: (value) {},
                    ),
                    SizedBox(
                      height: Spacing.smMedium,
                    ),
                    LemonTextField(
                      label: "Description*",
                      onChange: (value) {},
                    ),
                  ],
                ),
              ),
              LinearGradientButton(
                label: "Create event",
                mode: GradientButtonMode.lavenderMode,
                height: 48.h,
                radius: BorderRadius.circular(24),
                textStyle: Typo.medium.copyWith(),
                onTap: () {
                  final createEventReq = GCreateEventReq(
                    (b) => b
                      ..vars.input.title = "test title"
                      ..vars.input.description = 'test description'
                      ..vars.input.private = false
                      ..vars.input.verify = false
                      ..vars.input.start = DateTime.now().toUtc()
                      ..vars.input.end = DateTime.now().toUtc()
                      ..vars.input.guest_limit = 100
                      ..vars.input.guest_limit_per = 2
                      ..vars.input.virtual = true,
                  );
                  client.request(createEventReq).listen((response) {
                    print('.......................');
                    print(response.hasErrors);
                    print(response.graphqlErrors);
                    print(response.linkException);
                    print(response.data!.createEvent.toString());
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
