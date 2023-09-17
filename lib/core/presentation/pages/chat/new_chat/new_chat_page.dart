import 'package:app/core/application/profile/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:app/core/domain/post/post_repository.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/core/presentation/widgets/lemon_bottom_sheet_mixin.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/service/post/post_service.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewChatPageDialog extends StatelessWidget with LemonBottomSheet {
  const NewChatPageDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final bloc = EditProfileBloc(
      getIt<UserRepository>(),
      PostService(getIt<PostRepository>()),
    );
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.status == EditProfileStatus.success) {
            context.router.popUntilRoot();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: LemonAppBar(
              backgroundColor: colorScheme.onPrimaryContainer,
            ),
            backgroundColor: colorScheme.onPrimaryContainer,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.smMedium),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox.expand(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
