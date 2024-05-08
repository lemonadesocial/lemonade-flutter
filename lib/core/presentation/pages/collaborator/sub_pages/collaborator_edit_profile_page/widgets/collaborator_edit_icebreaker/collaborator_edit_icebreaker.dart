import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_icebreaker/widgets/collaborator_select_icebreaker_prompt_bottomsheet.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/remove_icon_wrapper.dart';
import 'package:app/core/presentation/widgets/common/button/lemon_outline_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CollaboratorEditIcebreakers extends StatelessWidget {
  const CollaboratorEditIcebreakers({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final loggedInUser = context.watch<UserProfileBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (profile) => profile,
        );
    final userIceBreakers = loggedInUser?.icebreakers ?? [];
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            t.collaborator.editProfile.icebreakers,
            style: Typo.mediumPlus.copyWith(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.xSmall),
        ),
        SliverToBoxAdapter(
          child: DottedBorder(
            color: colorScheme.outline,
            borderType: BorderType.RRect,
            dashPattern: [6.w, 6.w],
            strokeWidth: 2.w,
            radius: Radius.circular(LemonRadius.small),
            child: LemonOutlineButton(
              onTap: () => showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: LemonColor.atomicBlack,
                builder: (mContext) =>
                    const CollaboratorSelectIcebreakerPromptBottomsheet(),
              ),
              borderColor: Colors.transparent,
              leading: ThemeSvgIcon(
                color: colorScheme.onSecondary,
                builder: (filter) => Assets.icons.icAdd.svg(
                  colorFilter: filter,
                ),
              ),
              label: t.collaborator.editProfile.addIcebreaker,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: Spacing.xSmall),
        ),
        SliverPadding(
          padding: EdgeInsets.only(right: Spacing.superExtraSmall),
          sliver: SliverList.separated(
            itemCount: userIceBreakers.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.xSmall),
            itemBuilder: (context, index) {
              final iceBreaker = userIceBreakers[index];
              return RemoveIconWrapper(
                onTap: () async {
                  List<Input$UserIcebreakerInput> inputIceBreakers =
                      userIceBreakers
                          .map(
                            (existingIceBreaker) => Input$UserIcebreakerInput(
                              question:
                                  existingIceBreaker.questionExpanded?.id ?? '',
                              value: existingIceBreaker.value ?? '',
                            ),
                          )
                          .toList();
                  inputIceBreakers.removeWhere(
                    (item) => item.question == iceBreaker.question,
                  );

                  await showFutureLoadingDialog(
                    context: context,
                    future: () {
                      return getIt<UserRepository>().updateUser(
                        input: Input$UserInput(icebreakers: inputIceBreakers),
                      );
                    },
                  );
                  context.read<UserProfileBloc>().add(
                        UserProfileEventFetch(
                          userId: AuthUtils.getUserId(context),
                        ),
                      );
                },
                child: _IcebreakerItem(
                  question: iceBreaker.questionExpanded?.title ?? '',
                  answer: iceBreaker.value ?? '',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _IcebreakerItem extends StatelessWidget {
  final String question;
  final String answer;
  const _IcebreakerItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: LemonColor.atomicBlack,
        borderRadius: BorderRadius.circular(LemonRadius.medium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Assets.icons.icQuote.svg(),
              SizedBox(width: Spacing.extraSmall),
              Flexible(
                flex: 5,
                child: Text(
                  question,
                  style: Typo.medium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Flexible(
                flex: 4,
                child: SizedBox.shrink(),
              ),
            ],
          ),
          SizedBox(height: Spacing.extraSmall),
          Text(
            answer,
            style: Typo.medium.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
