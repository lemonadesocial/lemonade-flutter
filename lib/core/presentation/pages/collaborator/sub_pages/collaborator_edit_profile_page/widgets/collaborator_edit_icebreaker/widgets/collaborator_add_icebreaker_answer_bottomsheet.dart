import 'package:app/app_theme/app_theme.dart';
import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user_icebreaker.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/bottomsheet_grabber/bottomsheet_grabber.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
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
    final appColors = context.theme.appColors;
    final appText = context.theme.appTextTheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.sm),
      borderSide: BorderSide(color: appColors.pageDivider),
    );

    final loggedInUser = context.read<AuthBloc>().state.maybeWhen(
          orElse: () => null,
          authenticated: (user) => user,
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
                    color: appColors.cardBg,
                    borderRadius: BorderRadius.circular(LemonRadius.sm),
                  ),
                  child: Text(
                    widget.userIceBreakerQuestion?.title ?? '',
                    style: appText.md,
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
                    cursorColor: appColors.textTertiary,
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
              color: appColors.pageBg,
              border: Border(
                top: BorderSide(
                  color: appColors.pageDivider,
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
                    context.read<AuthBloc>().add(const AuthEvent.refreshData());
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
