import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CollaboratorEditOfferingBottomSheet extends StatefulWidget {
  const CollaboratorEditOfferingBottomSheet({super.key});

  @override
  CollaboratorEditOfferingBottomSheetState createState() =>
      CollaboratorEditOfferingBottomSheetState();
}

class CollaboratorEditOfferingBottomSheetState
    extends State<CollaboratorEditOfferingBottomSheet> {
  List<String> selectedOffering = [];
  String searchValue = '';

  @override
  void initState() {
    super.initState();
    final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    setState(() {
      selectedOffering = loggedInUser!.serviceOffersExpanded!
          .map<String>((item) => item.id!)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: LemonColor.atomicBlack,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            title: t.collaborator.offering,
            backgroundColor: LemonColor.atomicBlack,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: Spacing.smMedium,
              right: Spacing.smMedium,
              top: Spacing.xSmall,
              bottom: Spacing.smMedium,
            ),
            child: LemonTextField(
              hintText: t.common.search.capitalize(),
              contentPadding: EdgeInsets.all(Spacing.small),
              onChange: (value) {
                setState(() {
                  searchValue = value.toLowerCase();
                });
              },
            ),
          ),
          FutureBuilder(
            future: getIt<UserRepository>().getListUserServices(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: Loading.defaultLoading(context),
                );
              }
              final offeringList =
                  snapshot.data?.fold((l) => null, (offering) => offering);
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: ListView.builder(
                    itemCount: offeringList?.length,
                    padding: EdgeInsets.only(bottom: Spacing.large),
                    itemBuilder: (BuildContext context, int index) {
                      final offering = offeringList?[index];
                      final offeringLower =
                          offering?.title?.toLowerCase() ?? '';
                      if (offering?.title != '' &&
                          offeringLower.contains(searchValue)) {
                        final isChecked =
                            selectedOffering.contains(offering?.id);
                        return _OfferingItem(
                          title: offering?.title ?? '',
                          isChecked: isChecked,
                          onChecked: (isChecked) {
                            setState(() {
                              if (isChecked) {
                                selectedOffering.add(offering?.id ?? '');
                              } else {
                                selectedOffering.remove(offering?.id ?? '');
                              }
                            });
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: LemonColor.atomicBlack,
                border: Border(top: BorderSide(color: colorScheme.outline)),
              ),
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: Opacity(
                  opacity: selectedOffering.isNotEmpty ? 1 : 0.5,
                  child: LinearGradientButton.primaryButton(
                    onTap: () async {
                      Vibrate.feedback(FeedbackType.light);
                      FocusManager.instance.primaryFocus?.unfocus();
                      await getIt<UserRepository>().updateUser(
                        input: Input$UserInput.fromJson({
                          "service_offers": selectedOffering,
                        }),
                      );
                      context.read<AuthBloc>().add(
                            const AuthEvent.refreshData(),
                          );
                      AutoRouter.of(context).pop();
                    },
                    label: t.common.apply,
                    textColor: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferingItem extends StatelessWidget {
  final String title;
  final bool isChecked;
  final Function(bool) onChecked;

  const _OfferingItem({
    required this.title,
    required this.isChecked,
    required this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onChecked(!isChecked);
      },
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Typo.mediumPlus.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            isChecked
                ? Assets.icons.icChecked.svg()
                : Assets.icons.icUncheck.svg(),
          ],
        ),
      ),
    );
  }
}
