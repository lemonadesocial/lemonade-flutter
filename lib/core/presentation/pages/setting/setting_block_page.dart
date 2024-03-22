import 'package:app/core/application/profile/block_user_bloc/block_user_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/lemon_circle_avatar_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/core/utils/dialog_utils.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingBlockPage extends StatefulWidget {
  const SettingBlockPage({super.key});

  @override
  State<SettingBlockPage> createState() => _SettingBlockPageState();
}

class _SettingBlockPageState extends State<SettingBlockPage> {
  late final t = Translations.of(context);
  late final colorScheme = Theme.of(context).colorScheme;
  late final authSession = AuthUtils.getUser(context)!;
  late final List<User> blockedList;

  @override
  void initState() {
    blockedList = authSession.blockedList ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlockUserBloc, BlockUserState>(
      listener: (context, state) {
        if (state.status == BlockUserStatus.unblockSuccess) {
          SnackBarUtils.showSuccess(message: t.profile.unblockSuccess);
          setState(() {
            blockedList.removeWhere((user) => user.userId == state.blockUserId);
          });
        }

        if (state.status == BlockUserStatus.error) {
          SnackBarUtils.showError();
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.primary,
        appBar: LemonAppBar(
          title: t.setting.blockAccount,
          leading: const LemonBackButton(),
        ),
        body: blockedList.isEmpty
            ? Center(child: EmptyList(emptyText: t.common.emptyList))
            : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Spacing.small),
                itemCount: blockedList.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: Spacing.superExtraSmall),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(Spacing.small),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(LemonRadius.normal),
                      color: LemonColor.black87,
                    ),
                    child: Row(
                      children: [
                        LemonCircleAvatar(
                          size: Sizing.medium,
                          url: blockedList[index].imageAvatar ?? '',
                        ),
                        SizedBox(width: Spacing.superExtraSmall),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blockedList[index].name ?? '',
                                style: Typo.medium
                                    .copyWith(color: colorScheme.onPrimary),
                              ),
                              Text(
                                blockedList[index].username != null
                                    ? '@${blockedList[index].username}'
                                    : '',
                                style: Typo.small.copyWith(
                                  color:
                                      colorScheme.onPrimary.withOpacity(0.56),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            DialogUtils.showConfirmDialog(
                              context,
                              message: t.profile.unBlockConfirm,
                              onConfirm: () {
                                context.router.pop();
                                context.read<BlockUserBloc>().blockUser(
                                      userId: blockedList[index].userId,
                                      isBlock: false,
                                    );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.xSmall,
                              vertical: Spacing.superExtraSmall,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(LemonRadius.normal),
                              border: Border.all(
                                color: colorScheme.onPrimary.withOpacity(0.56),
                              ),
                            ),
                            child: Text(
                              t.common.actions.unBlock,
                              style: Typo.small.copyWith(
                                color: colorScheme.onPrimary.withOpacity(0.56),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
