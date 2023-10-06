import 'package:app/core/application/community/community_bloc.dart';
import 'package:app/core/presentation/widgets/lemon_text_field.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/utils/auth_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityFollowerView extends StatelessWidget {
  const CommunityFollowerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final userId = AuthUtils.getUserId(context);
    context.read<CommunityBloc>().getListFollower(userId);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Spacing.xSmall),
        child: Column(
          children: [
            LemonTextField(
              leadingIcon: ThemeSvgIcon(
                color: colorScheme.onSurfaceVariant,
                builder: (filter) => Assets.icons.icSearch.svg(
                  colorFilter: filter,
                  width: 18.w,
                  height: 18.w,
                  fit: BoxFit.scaleDown,
                ),
              ),
              hintText: t.setting.searchCommunity,
              contentPadding: EdgeInsets.all(Spacing.small),
              onChange: (value) {},
            ),
            SizedBox(height: Spacing.small),
          ],
        ),
      ),
    );
  }
}
