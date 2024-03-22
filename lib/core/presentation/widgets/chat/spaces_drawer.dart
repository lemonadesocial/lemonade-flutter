import 'package:app/core/application/chat/chat_space_bloc/chat_space_bloc.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matrix/matrix.dart';

class SpacesDrawer extends StatelessWidget {
  const SpacesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Drawer(
        width: 300,
        backgroundColor: colorScheme.primary,
        child: BlocBuilder<ChatSpaceBloc, ChatSpaceState>(
          builder: (context, chatSpaceState) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: Spacing.small,
                  horizontal: Spacing.smMedium,
                ),
                child: Row(
                  children: [
                    Text(
                      StringUtils.capitalize(t.chat.spaces),
                      style: Typo.extraMedium
                          .copyWith(color: colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
              _buildSpaceItem(
                context,
                isActive: chatSpaceState.activeSpace == null,
                isRoot: true,
                onTap: () {
                  context.read<ChatSpaceBloc>().add(
                        const ChatSpaceEvent.setActiveSpace(space: null),
                      );
                  Navigator.of(context).pop();
                },
              ),
              ...chatSpaceState.spaces.map(
                (space) => _buildSpaceItem(
                  context,
                  space: space,
                  isActive: chatSpaceState.activeSpace?.id == space.id,
                  onTap: () {
                    context.read<ChatSpaceBloc>().add(
                          ChatSpaceEvent.setActiveSpace(space: space),
                        );
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const Spacer(),
              _buildSpaceActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpaceItem(
    BuildContext context, {
    Room? space,
    bool isActive = false,
    bool isRoot = false,
    Function()? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Spacing.small),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            10,
          ), // Set the border radius for the blue container
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.xSmall,
              horizontal: Spacing.xSmall,
            ),
            color: isActive ? colorScheme.surfaceVariant : Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (space != null)
                  MatrixAvatar(
                    mxContent: space.avatar,
                    size: 42,
                    name: space.name,
                  ),
                if (space == null && isRoot)
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ThemeSvgIcon(
                      builder: (filter) => Assets.icons.icLemonadeWhite.svg(),
                    ),
                  ),
                SizedBox(width: Spacing.xSmall),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringUtils.capitalize(
                          isRoot
                              ? t.common.lemonade
                              : space?.getLocalizedDisplayname(),
                        ),
                        style: Typo.medium.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.87),
                        ),
                        maxLines: 2,
                      ),
                      if (space?.canonicalAlias.isNotEmpty == true) ...[
                        SizedBox(height: Spacing.superExtraSmall),
                        Text(
                          space!.canonicalAlias.replaceFirst("#", ""),
                          style: Typo.small.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpaceActions(
    context,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Spacing.small),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              SnackBarUtils.showComingSoon(context: context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.xSmall,
                horizontal: Spacing.xSmall,
              ),
              child: Row(
                children: [
                  ThemeSvgIcon(
                    color: colorScheme.onPrimary,
                    builder: (filter) => Assets.icons.icoCreateSpace.svg(
                      colorFilter: filter,
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Text(
                    "Create space",
                    style: Typo.medium.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              SnackBarUtils.showComingSoon(context: context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Spacing.xSmall,
                horizontal: Spacing.xSmall,
              ),
              child: Row(
                children: [
                  ThemeSvgIcon(
                    color: colorScheme.onPrimary,
                    builder: (filter) => Assets.icons.icJoinSpace.svg(
                      colorFilter: filter,
                    ),
                  ),
                  SizedBox(width: Spacing.small),
                  Text(
                    "Join space",
                    style: Typo.medium.copyWith(color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Spacing.medium,
          ),
        ],
      ),
    );
  }
}
