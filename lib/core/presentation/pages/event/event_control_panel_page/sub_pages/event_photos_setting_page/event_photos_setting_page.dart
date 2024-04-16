import 'package:app/core/application/event/get_event_detail_bloc/get_event_detail_bloc.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_photos_setting_page/widgets/cover_photo_item.dart';
import 'package:app/core/presentation/pages/event/event_control_panel_page/sub_pages/event_photos_setting_page/widgets/upload_photo_item.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EventPhotosSettingPage extends StatelessWidget {
  const EventPhotosSettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final event = context.watch<GetEventDetailBloc>().state.maybeWhen(
          orElse: () => null,
          fetched: (event) => event,
        );
    final eventPhotos = (event?.newNewPhotosExpanded ?? [])
        .where((element) => element != null)
        .cast<DbFile>()
        .toList();
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: LemonAppBar(
        title: StringUtils.capitalize(
          t.common.photo(n: 2),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CoverPhotoItem(
                    photo: eventPhotos.isNotEmpty ? eventPhotos.first : null,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.large),
                ),
                if (eventPhotos.isNotEmpty)
                  SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: Spacing.xSmall,
                      crossAxisSpacing: Spacing.xSmall,
                    ),
                    itemCount: eventPhotos.length,
                    itemBuilder: (context, index) {
                      return UploadPhotoItem(
                        photo: eventPhotos[index],
                        index: index,
                      );
                    },
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xLarge * 3.5),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline,
                  ),
                ),
                color: colorScheme.background,
              ),
              padding: EdgeInsets.all(Spacing.smMedium),
              child: SafeArea(
                child: LinearGradientButton.secondaryButton(
                  label: t.event.eventPhotos.addPhoto,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
