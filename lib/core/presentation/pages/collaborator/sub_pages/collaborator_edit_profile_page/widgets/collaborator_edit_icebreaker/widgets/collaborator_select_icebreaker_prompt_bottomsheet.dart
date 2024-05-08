import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/pages/collaborator/sub_pages/collaborator_edit_profile_page/widgets/collaborator_edit_icebreaker/widgets/collaborator_add_icebreaker_answer_bottomsheet.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/gen/fonts.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CollaboratorSelectIcebreakerPromptBottomsheet extends StatelessWidget {
  const CollaboratorSelectIcebreakerPromptBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: LemonColor.atomicBlack,
      body: SafeArea(
        child: Column(
          children: [
            const BottomSheetGrabber(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: LemonAppBar(
                      backgroundColor: LemonColor.atomicBlack,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
                    sliver: MultiSliver(
                      children: [
                        SliverToBoxAdapter(
                          child: Text(
                            t.collaborator.editProfile.icebreakers,
                            style: Typo.extraLarge.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.nohemiVariable,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 2.w,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Text(
                            t.collaborator.editProfile.selectPromptDescription,
                            style: Typo.mediumPlus.copyWith(
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(height: Spacing.medium),
                        ),
                        FutureBuilder(
                          future: getIt<UserRepository>()
                              .getUserIcebreakerQuestions(),
                          builder: (context, snapshot) {
                            final userIcebreakerQuestions = snapshot.data
                                ?.fold((l) => null, (item) => item);
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Loading.defaultLoading(context),
                              );
                            }
                            return SliverList.separated(
                              itemCount: userIcebreakerQuestions?.length ?? 0,
                              itemBuilder: (context, index) {
                                final userIceBreakerQuestion =
                                    userIcebreakerQuestions?[index];
                                return InkWell(
                                  onTap: () {
                                    showCupertinoModalBottomSheet(
                                      context: context,
                                      barrierColor:
                                          Colors.black.withOpacity(0.8),
                                      backgroundColor: LemonColor.atomicBlack,
                                      builder: (mContext) =>
                                          CollaboratorAddIcebreakerAnswerBottomsheet(
                                        userIceBreakerQuestion:
                                            userIceBreakerQuestion,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(Spacing.small),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        LemonRadius.extraSmall,
                                      ),
                                      color: colorScheme.secondaryContainer,
                                    ),
                                    child: Text(
                                      userIceBreakerQuestion?.title ?? '',
                                      style: Typo.medium.copyWith(
                                        color: colorScheme.onPrimary,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                height: Spacing.extraSmall,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
