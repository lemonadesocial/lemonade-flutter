import 'package:app/core/application/chat/chat_list_bloc/chat_list_bloc.dart';
import 'package:app/core/application/chat/chat_space_bloc/chat_space_bloc.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/chat_list_item.dart';
import 'package:app/core/presentation/widgets/chat/create_chat_button.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/chat/spaces_drawer.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/stream_extension.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';

class ChatListPageView extends StatefulWidget {
  const ChatListPageView({super.key});

  @override
  State<ChatListPageView> createState() => _ChatListPageViewState();
}

class _ChatListPageViewState extends State<ChatListPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final activeSpace = context.read<ChatSpaceBloc>().state.activeSpace;
    return Scaffold(
      appBar: LemonAppBar(
        title: activeSpace != null
            ? activeSpace.getLocalizedDisplayname()
            : t.common.lemonade,
        actions: [
          BlocBuilder<ChatSpaceBloc, ChatSpaceState>(
            builder: (context, chatSpaceState) => Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  alignment: Alignment.centerRight,
                  child: Center(
                    child: SizedBox(
                      child: chatSpaceState.activeSpace != null
                          ? MatrixAvatar(
                              size: 27.w,
                              mxContent: chatSpaceState.activeSpace?.avatar,
                              name: chatSpaceState.activeSpace?.name,
                              fontSize: Typo.small.fontSize!,
                            )
                          : Container(
                              width: 27.w,
                              height: 27.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: ThemeSvgIcon(
                                color: colorScheme.onSurface,
                                builder: (filter) =>
                                    Assets.icons.icLemonadeWhite.svg(),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      endDrawer: const SpacesDrawer(),
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: StreamBuilder(
          stream: getIt<MatrixService>()
              .client
              .onSync
              .stream
              .where((event) => event.hasRoomUpdate)
              .rateLimit(const Duration(seconds: 1)),
          builder: (context, snapshot) =>
              BlocBuilder<ChatListBloc, ChatListState>(
            builder: (context, chatListState) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TabBar(
                    controller: _tabController,
                    labelStyle: Typo.medium.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: Typo.medium.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    indicatorColor: LemonColor.paleViolet,
                    tabs: [
                      Tab(text: StringUtils.capitalize(t.chat.directMessages)),
                      Tab(text: StringUtils.capitalize(t.chat.channels)),
                    ],
                  ),
                  SizedBox(height: Spacing.extraSmall),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        CustomScrollView(
                          slivers: [
                            _ChatListSection(
                              title:
                                  StringUtils.capitalize(t.chat.directMessages),
                              rooms: chatListState.dmRooms,
                              itemBuilder: (room) => ChatListItem(room: room),
                            ),
                          ],
                        ),
                        CustomScrollView(
                          slivers: [
                            _ChatListSection(
                              title: StringUtils.capitalize(t.chat.channels),
                              rooms: chatListState.channelRooms,
                              itemBuilder: (room) => ChatListItem(room: room),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: const CreateChatButton(),
    );
  }
}

class _ChatListSection extends StatelessWidget {
  const _ChatListSection({
    required this.title,
    required this.rooms,
    required this.itemBuilder,
  });

  final String title;
  final List<Room> rooms;
  final Widget Function(Room room) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: rooms.length,
      itemBuilder: (context, index) => itemBuilder(rooms[index]),
      separatorBuilder: (context, index) =>
          SizedBox(height: Spacing.extraSmall),
    );
  }
}
