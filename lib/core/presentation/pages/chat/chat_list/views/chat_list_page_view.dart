import 'package:app/core/application/chat/chat_list_bloc/chat_list_bloc.dart';
import 'package:app/core/application/chat/chat_space_bloc/chat_space_bloc.dart';
import 'package:app/core/application/chat/get_guild_rooms_bloc/get_guild_rooms_bloc.dart';
import 'package:app/core/presentation/pages/chat/chat_list/views/check_guild_room_roles_bottomsheet.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/chat_list_item.dart';
import 'package:app/core/presentation/pages/chat/chat_list/widgets/guild_room_item.dart';
import 'package:app/core/presentation/widgets/chat/create_chat_button.dart';
import 'package:app/core/presentation/widgets/chat/matrix_avatar.dart';
import 'package:app/core/presentation/widgets/chat/spaces_drawer.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/presentation/widgets/theme_svg_icon_widget.dart';
import 'package:app/core/service/matrix/matrix_service.dart';
import 'package:app/core/utils/stream_extension.dart';
import 'package:app/core/utils/string_utils.dart';
import 'package:app/gen/assets.gen.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/router/app_router.gr.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matrix/matrix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

enum ChatListTabs {
  messages(tabIndex: 0),
  channels(tabIndex: 1),
  guilds(tabIndex: 2);

  const ChatListTabs({
    required this.tabIndex,
  });

  final int tabIndex;
}

class ChatListPageView extends StatefulWidget {
  const ChatListPageView({
    super.key,
  });

  @override
  State<ChatListPageView> createState() => _ChatListPageViewState();
}

class _ChatListPageViewState extends State<ChatListPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int selectedTabIndex = ChatListTabs.messages.index;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                    onTap: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
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
                      Tab(text: StringUtils.capitalize(t.chat.messages)),
                      Tab(text: StringUtils.capitalize(t.chat.channels)),
                      Tab(text: StringUtils.capitalize(t.chat.guilds)),
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
                              emptyText: t.chat.emptyDirectMessages,
                            ),
                          ],
                        ),
                        CustomScrollView(
                          slivers: [
                            _ChatListSection(
                              title: StringUtils.capitalize(t.chat.channels),
                              rooms: chatListState.channelRooms,
                              itemBuilder: (room) => ChatListItem(room: room),
                              emptyText: t.chat.emptyChannels,
                            ),
                          ],
                        ),
                        CustomScrollView(
                          slivers: [
                            BlocBuilder<GetGuildRoomsBloc, GetGuildRoomsState>(
                              builder: (context, guildRoomsState) {
                                return guildRoomsState.maybeWhen(
                                  orElse: () => const SliverToBoxAdapter(
                                    child: SizedBox.shrink(),
                                  ),
                                  loading: () => SliverToBoxAdapter(
                                    child: Loading.defaultLoading(context),
                                  ),
                                  failure: () => SliverToBoxAdapter(
                                    child: EmptyList(
                                      emptyText: t.common.somethingWrong,
                                    ),
                                  ),
                                  success: (guildRooms) {
                                    return SliverList.separated(
                                      itemCount: guildRooms.length,
                                      itemBuilder: (context, index) =>
                                          GuildRoomItem(
                                        guildRoom: guildRooms[index],
                                        onTap: () {
                                          showCupertinoModalBottomSheet(
                                            barrierColor: LemonColor.black50,
                                            bounce: true,
                                            backgroundColor:
                                                LemonColor.atomicBlack,
                                            context: context,
                                            builder: (newContext) {
                                              return CheckGuildRoomRolesBottomSheet(
                                                guildRoom: guildRooms[index],
                                                onEnterChannel: () {
                                                  AutoRouter.of(context)
                                                      .navigate(
                                                    ChatRoute(
                                                      roomId: guildRooms[index]
                                                              .matrixRoomId ??
                                                          '',
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: Spacing.extraSmall),
                                    );
                                  },
                                );
                              },
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
      floatingActionButton:
          CreateChatButton(selectedTabIndex: selectedTabIndex),
    );
  }
}

class _ChatListSection extends StatelessWidget {
  const _ChatListSection({
    required this.title,
    required this.rooms,
    required this.itemBuilder,
    this.emptyText,
  });

  final String title;
  final List<Room> rooms;
  final Widget Function(Room room) itemBuilder;
  final String? emptyText;

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return SliverToBoxAdapter(
        child: EmptyList(emptyText: emptyText),
      );
    }

    return SliverList.separated(
      itemCount: rooms.length,
      itemBuilder: (context, index) => itemBuilder(rooms[index]),
      separatorBuilder: (context, index) =>
          SizedBox(height: Spacing.extraSmall),
    );
  }
}
