import 'package:app/core/constants/event/event_constants.dart';
import 'package:app/core/domain/event/entities/event.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/presentation/widgets/common/scaffold/loader_scaffold_page/loader_scaffold_page.dart';
import 'package:app/core/presentation/widgets/common/scaffold/success_scaffold_page/success_scaffold_page.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';

@RoutePage<EventActionType?>()
class EventPublishingPage extends StatefulWidget {
  final Widget Function(BuildContext context)? successButtonBuilder;
  final Event event;
  const EventPublishingPage({
    super.key,
    required this.event,
    this.successButtonBuilder,
  });

  @override
  State<EventPublishingPage> createState() => _EventPublishingPageState();
}

class _EventPublishingPageState extends State<EventPublishingPage> {
  @override
  Widget build(BuildContext context) {
    final isSubEvent = widget.event.subeventParent?.isNotEmpty ?? false;
    final t = Translations.of(context);
    return FutureBuilder(
      future: getIt<EventRepository>()
          .updateEvent(
        input: Input$EventInput(published: true),
        id: widget.event.id ?? '',
      )
          .onError((error, stackTrace) {
        AutoRouter.of(context).pop();
        return dartz.Left(Failure());
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SuccessScaffoldPage(
            title: isSubEvent
                ? t.event.eventPublish.sessionPublishedTitle
                : t.event.eventPublish.eventPublishedTitle,
            description: isSubEvent
                ? t.event.eventPublish.sessionPublishedDescription
                : t.event.eventPublish.eventPublishedDescription,
            buttonBuilder: widget.successButtonBuilder,
          );
        }
        return LoaderScaffoldPage(
          title: isSubEvent
              ? t.event.eventPublish.publishingSession
              : t.event.eventPublish.publishingEvent,
          description: t.event.eventPublish.publishingDescription,
        );
      },
    );
  }
}
