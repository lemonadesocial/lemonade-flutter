import 'package:app/core/application/space/pin_existing_event_to_space_bloc/pin_existing_event_to_space_bloc.dart';
import 'package:app/core/domain/space/entities/pin_events_to_space_response.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/domain/space/space_repository.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PinExistingEventToSpacePage extends StatelessWidget {
  static Future<PinEventsToSpaceResponse?> show(
    BuildContext context, {
    required Space space,
  }) {
    return showCupertinoModalBottomSheet<PinEventsToSpaceResponse?>(
      context: context,
      backgroundColor: LemonColor.atomicBlack,
      barrierColor: Colors.black.withOpacity(0.5),
      expand: false,
      builder: (context) => PinExistingEventToSpacePage(space: space),
    );
  }

  final Space space;
  const PinExistingEventToSpacePage({
    super.key,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PinExistingEventToSpaceBloc(
        getIt<SpaceRepository>(),
      ),
      child: _View(space: space),
    );
  }
}

class _View extends StatefulWidget {
  final Space space;
  const _View({
    required this.space,
  });

  @override
  State<_View> createState() => __ViewState();
}

class __ViewState extends State<_View> {
  final controller = TextEditingController();
  bool hasValue = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        hasValue = controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<PinExistingEventToSpaceBloc,
        PinExistingEventToSpaceState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (response) {
            if (response.requests == null ||
                response.requests?.isEmpty == true) {
              SnackBarUtils.showSuccess(
                message: t.space.eventSubmitted,
              );
            } else {
              SnackBarUtils.showSuccess(
                message: t.space.eventSubmissionRequested,
              );
            }
            Navigator.pop(context, response);
          },
          failure: (failure) {
            SnackBarUtils.showError(message: failure.message);
          },
          eventNotFound: () {
            SnackBarUtils.showError(
              message: t.space.eventNotFound,
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state is PinExistingEventToSpaceStateLoading;
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.center,
                child: BottomSheetGrabber(),
              ),
              Padding(
                padding: EdgeInsets.all(Spacing.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      t.space.existingEvent.title,
                      style: Typo.extraLarge.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                    SizedBox(height: Spacing.small),
                    Text(
                      t.space.existingEvent.description,
                      style: Typo.medium.copyWith(
                        color: colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: Spacing.medium),
                    LemonTextField(
                      controller: controller,
                      filled: true,
                      fillColor: LemonColor.chineseBlack,
                      borderColor: Colors.transparent,
                      hintText: "Enter event link",
                    ),
                    SizedBox(height: Spacing.medium),
                    SafeArea(
                      top: false,
                      child: Opacity(
                        opacity: hasValue ? 1 : 0.5,
                        child: LinearGradientButton.primaryButton(
                          loadingWhen: isLoading,
                          label: t.space.submitEvent,
                          onTap: () {
                            if (!hasValue) {
                              return;
                            }
                            if (isLoading || widget.space.id == null) {
                              return;
                            }
                            context.read<PinExistingEventToSpaceBloc>().add(
                                  PinExistingEventToSpaceEvent.pinEvent(
                                    eventUrl: controller.text,
                                    spaceId: widget.space.id!,
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
