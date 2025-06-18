import 'dart:collection';

import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/collaborator/discover_users_bloc/discover_user_bloc.dart';
import 'package:app/core/data/user/dtos/user_service_offer_dto/user_service_offer_dto.dart';
import 'package:app/core/domain/user/entities/user_service_offer.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/widgets/collaborator_user_bottomsheet_header/collaborator_user_bottomsheet_header.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/user/query/list_user_services.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

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
            isLoading: result.isLoading,
          ),
        );
      },
    );
  }
}

class _FilterView extends StatefulWidget {
  final List<UserServiceOffer> userServicesOffers;
  final List<String> initialFilteredOfferings;
  final bool isLoading;
  const _FilterView({
    required this.userServicesOffers,
    this.initialFilteredOfferings = const [],
    this.isLoading = false,
  });

  @override
  State<_FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<_FilterView> {
  List<UserServiceOffer> searchList = [];
  List<String> selectedOfferings = [];

  @override
  void didUpdateWidget(covariant _FilterView oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      searchList = widget.userServicesOffers;
      selectedOfferings = widget.initialFilteredOfferings;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      searchList = widget.userServicesOffers;
      selectedOfferings = widget.initialFilteredOfferings;
    });
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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
        );
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      color: appColors.pageBg,
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
                          color: appColors.textTertiary,
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
                      style: appText.md.copyWith(
                        color: appColors.textTertiary,
                      ),
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
                            backgroundColor: appColors.buttonTertiaryBg,
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
              if (widget.isLoading)
                Center(
                  child: Loading.defaultLoading(context),
                ),
              if (searchList.isNotEmpty)
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
                                  style: appText.md,
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
                    color: appColors.pageDivider,
                  ),
                ),
                color: appColors.pageBg,
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
