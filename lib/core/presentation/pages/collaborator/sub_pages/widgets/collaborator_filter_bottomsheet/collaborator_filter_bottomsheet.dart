import 'dart:collection';

import 'package:app/core/application/collaborator/discover_users_bloc/discover_user_bloc.dart';
import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/data/user/dtos/user_service_offer_dto/user_service_offer_dto.dart';
import 'package:app/core/domain/user/entities/user_service_offer.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_user_bottomsheet_header/collaborator_user_bottomsheet_header.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/user/query/list_user_services.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

// TODO: will remove
final mockData = [
  UserServiceOffer(
    id: '1',
    title: "Create new concept",
  ),
  UserServiceOffer(
    id: '2',
    title: "Design advice",
  ),
  UserServiceOffer(
    id: '3',
    title: "Perform video editing",
  ),
  UserServiceOffer(
    id: '4',
    title: "Financial advice",
  ),
  UserServiceOffer(
    id: '5',
    title: "Execute email marketing",
  ),
  UserServiceOffer(
    id: '6',
    title: "Manage budget",
  ),
  UserServiceOffer(
    id: '7',
    title: "Develop marketing strategy",
  ),
  UserServiceOffer(
    id: '8',
    title: "Write blog posts",
  ),
  UserServiceOffer(
    id: '9',
    title: "Optimize website performance",
  ),
  UserServiceOffer(
    id: '10',
    title: "Provide customer support",
  ),
  UserServiceOffer(
    id: '11',
    title: "Conduct market research",
  ),
];

class CollaboratorFilterBottomSheet extends StatelessWidget {
  const CollaboratorFilterBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Query$ListUserServices$Widget(
      builder: (
        result, {
        refetch,
        fetchMore,
      }) {
        final userServiceOffers =
            (result.parsedData?.listUserServices ?? []).map((item) {
          return UserServiceOffer.fromDto(
            UserServiceOfferDto.fromJson(item.toJson()),
          );
        }).toList();

        return BlocBuilder<DiscoverUserBloc, DiscoverUserState>(
          builder: (context, state) => _FilterView(
            userServicesOffers: userServiceOffers,
            initialFilteredOfferings: state.filteredOfferings,
          ),
        );
      },
    );
  }
}

class _FilterView extends StatefulWidget {
  final List<UserServiceOffer> userServicesOffers;
  final List<String> initialFilteredOfferings;
  const _FilterView({
    required this.userServicesOffers,
    this.initialFilteredOfferings = const [],
  });

  @override
  State<_FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<_FilterView> {
  List<UserServiceOffer> searchList = [];
  List<String> selectedOfferings = [];

  @override
  void initState() {
    super.initState();
    searchList = widget.userServicesOffers;
    selectedOfferings = widget.initialFilteredOfferings;
  }

  void _onSearchServiceOffer(String query) {
    if (query.isEmpty) {
      setState(() {
        searchList = widget.userServicesOffers;
      });
      return;
    }
    final regexp = RegExp(query.toLowerCase(), caseSensitive: false);
    final resultSet = HashSet<UserServiceOffer>();
    for (final item in widget.userServicesOffers) {
      if (regexp.hasMatch(item.title ?? '')) {
        resultSet.add(item);
      }
    }
    setState(() {
      searchList = resultSet.toList();
    });
  }

  void _selectOffering(String serviceOfferId) {
    setState(() {
      selectedOfferings = [...selectedOfferings, serviceOfferId];
    });
  }

  void _removeOffering(String serviceOfferId) {
    setState(() {
      selectedOfferings = selectedOfferings
          .where((element) => element != serviceOfferId)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final loggedInUser = context.read<UserProfileBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (profile) => profile,
        );
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: colorScheme.secondaryContainer,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BottomSheetGrabber(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: Spacing.xSmall,
                  bottom: Spacing.smMedium,
                  left: Spacing.smMedium,
                  right: Spacing.smMedium,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        AutoRouter.of(context)
                            .push(const CollaboratorEditProfileRoute());
                      },
                      child: CollaboratorUserBottomsheetHeader(
                        user: loggedInUser,
                        icon: ThemeSvgIcon(
                          color: colorScheme.onSecondary,
                          builder: (filter) {
                            return Assets.icons.icEdit.svg(
                              colorFilter: filter,
                              width: Sizing.medium / 2,
                              height: Sizing.medium / 2,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: Spacing.smMedium),
                    Text(
                      t.collaborator.filter.whatAreYouLookingFor,
                      style:
                          Typo.medium.copyWith(color: colorScheme.onSecondary),
                    ),
                    SizedBox(height: Spacing.xSmall),
                    LemonTextField(
                      hintText: t.collaborator.filter.startTypingSomething,
                      contentPadding: EdgeInsets.all(Spacing.small),
                      onChange: _onSearchServiceOffer,
                    ),
                  ],
                ),
              ),
              if (selectedOfferings.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: Wrap(
                    runSpacing: Spacing.superExtraSmall,
                    spacing: Spacing.superExtraSmall,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: selectedOfferings.map((serviceOfferId) {
                      final targetItem =
                          widget.userServicesOffers.firstWhereOrNull(
                        (element) => element.id == serviceOfferId,
                      );
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LemonOutlineButton(
                            onTap: () => _removeOffering(serviceOfferId),
                            radius: BorderRadius.circular(LemonRadius.normal),
                            borderColor: Colors.transparent,
                            backgroundColor: colorScheme.surface,
                            label: targetItem?.title ?? '',
                            trailing: Assets.icons.icClose.svg(
                              width: 12.w,
                              height: 12.w,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: Spacing.smMedium),
              ],
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                  child: ListView.builder(
                    itemCount: searchList.length,
                    padding: EdgeInsets.only(bottom: Spacing.large * 4),
                    itemBuilder: (BuildContext context, int index) {
                      final item = searchList[index];
                      final selected = selectedOfferings.contains(item.id);

                      return InkWell(
                        onTap: () {
                          if (selected) {
                            _removeOffering(item.id ?? '');
                          } else {
                            _selectOffering(item.id ?? '');
                          }
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: Spacing.small),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item.title ?? '',
                                style: Typo.mediumPlus.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (selected)
                                Assets.icons.icChecked.svg(
                                  width: 18.w,
                                  height: 18.w,
                                )
                              else
                                Assets.icons.icUncheck.svg(
                                  width: 18.w,
                                  height: 18.w,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(Spacing.smMedium),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
                color: colorScheme.secondaryContainer,
              ),
              child: SafeArea(
                child: LinearGradientButton.primaryButton(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    context.read<DiscoverUserBloc>().add(
                          DiscoverUserEvent.onUpdateFilter(
                            filteredOfferings: selectedOfferings,
                          ),
                        );
                  },
                  label: t.common.apply,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
