import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCommentInput extends StatefulWidget {
  final Function(String text)? onPressSubmit;
  const PostCommentInput({
    super.key,
    this.onPressSubmit,
  });

  @override
  State<PostCommentInput> createState() => _PostCommentInputState();
}

class _PostCommentInputState extends State<PostCommentInput> {
  final controller = TextEditingController();
  bool isValid = false;

  void submit() {
    widget.onPressSubmit?.call(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn =
        context.watch<AuthBloc>().state is AuthStateAuthenticated;
    final colorScheme = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(LemonRadius.button),
      borderSide: BorderSide(
        width: 1.w,
        color: colorScheme.outline,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.background,
        border: Border(top: BorderSide(color: colorScheme.outline, width: 1.w)),
      ),
      padding: EdgeInsets.all(
        Spacing.xSmall,
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 90.w, minHeight: 42.w),
                child: TextField(
                  controller: controller,
                  onTapOutside: (e) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (value) {
                    setState(() {
                      isValid = value.trim().isNotEmpty;
                    });
                  },
                  maxLines: null,
                  cursorColor: colorScheme.onPrimary,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Spacing.extraSmall,
                      horizontal: Spacing.smMedium,
                    ),
                    focusedBorder: border,
                    border: border,
                    hintText: "post your reply..",
                    hintStyle: Typo.mediumPlus
                        .copyWith(color: colorScheme.outlineVariant),
                    enabledBorder: border,
                  ),
                ),
              ),
            ),
            SizedBox(width: Spacing.superExtraSmall),
            InkWell(
              onTap: () {
                if (!isLoggedIn) {
                  AutoRouter.of(context).navigate(LoginRoute());
                  return;
                }
                if (!isValid) return;
                submit();
              },
              child: Opacity(
                opacity: isValid ? 1 : 0.5,
                child: Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(42.w),
                    gradient: LinearGradient(
                      colors: GradientButtonMode.defaultMode.gradients,
                    ),
                  ),
                  child: Center(
                    child: Assets.icons.icSendMessage.svg(
                      width: Sizing.xSmall,
                      height: Sizing.xSmall,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
