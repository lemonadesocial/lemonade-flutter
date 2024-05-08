import 'dart:ffi';

import 'package:app/core/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:app/core/domain/user/entities/user_icebreaker.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CollaboratorAddIcebreakerAnswerBottomsheet extends StatefulWidget {
  final UserIcebreakerQuestion? userIceBreakerQuestion;

  const CollaboratorAddIcebreakerAnswerBottomsheet({
    super.key,
    this.userIceBreakerQuestion,
  });

  @override
  CollaboratorAddIcebreakerAnswerBottomsheetState createState() =>
      CollaboratorAddIcebreakerAnswerBottomsheetState();
}

class CollaboratorAddIcebreakerAnswerBottomsheetState
    extends State<CollaboratorAddIcebreakerAnswerBottomsheet> {
  String answer = '';

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.small),
      borderSide: BorderSide(color: colorScheme.outline),
    );

    final loggedInUser = context.read<UserProfileBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (profile) => profile,
        );
    final existingIceBreakers = loggedInUser?.icebreakers ?? [];
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetGrabber(),
          LemonAppBar(
            title: t.collaborator.editProfile.addIcebreaker,
            backgroundColor: LemonColor.atomicBlack,
          ),
          Padding(
            padding: EdgeInsets.all(Spacing.smMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Spacing.small),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(LemonRadius.medium),
                  ),
                  child: Text(
                    widget.userIceBreakerQuestion?.title ?? '',
                    style: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                SizedBox(height: Spacing.xSmall),
                SizedBox(
                  height: 140.w,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        answer = value;
                      });
                    },
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    autofocus: true,
                    cursorColor: colorScheme.onSecondary,
                    decoration: InputDecoration(
                      hintText:
                          t.collaborator.editProfile.addPromptAnswerPlaceholder,
                      filled: true,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(Spacing.smMedium),
            decoration: BoxDecoration(
              color: LemonColor.atomicBlack,
              border: Border(
                top: BorderSide(
                  color: colorScheme.outline,
                ),
              ),
            ),
            child: SafeArea(
              child: Opacity(
                opacity: answer.isNotEmpty ? 1 : 0.5,
                child: LinearGradientButton.primaryButton(
                  label: t.common.actions.add,
                  onTap: () async {
                    Vibrate.feedback(FeedbackType.light);
                    FocusManager.instance.primaryFocus?.unfocus();
                    List<Input$UserIcebreakerInput> inputIceBreakers =
                        existingIceBreakers
                            .map(
                              (existingIceBreaker) => Input$UserIcebreakerInput(
                                question:
                                    existingIceBreaker.questionExpanded?.id ??
                                        '',
                                value: existingIceBreaker.value ?? '',
                              ),
                            )
                            .toList();
                    final widgetUserIceBreakerQuestion =
                        widget.userIceBreakerQuestion;
                    if (widgetUserIceBreakerQuestion != null) {
                      inputIceBreakers.add(
                        Input$UserIcebreakerInput(
                          question: widgetUserIceBreakerQuestion.id ?? '',
                          value: answer,
                        ),
                      );
                    }
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
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
