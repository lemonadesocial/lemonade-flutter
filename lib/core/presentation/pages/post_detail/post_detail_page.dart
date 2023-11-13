import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/application/post/create_post_comment_bloc/create_post_comment_bloc.dart';
import 'package:app/core/application/post/get_post_comments_bloc/get_post_comments_bloc.dart';
import 'package:app/core/application/post/toggle_post_reaction_bloc/toggle_post_reaction_bloc.dart';
import 'package:app/core/domain/post/entities/post_entities.dart';
import 'package:app/core/domain/post/input/create_post_comment_input.dart';
import 'package:app/core/domain/post/input/get_post_comments_input.dart';
import 'package:app/core/presentation/pages/post_detail/widgets/post_comment_input.dart';
import 'package:app/core/presentation/pages/post_detail/widgets/post_comment_tile.dart';
import 'package:app/core/presentation/pages/post_detail/widgets/post_detail_card.dart';
import 'package:app/core/presentation/widgets/back_button_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/list/empty_list_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PostDetailPage extends StatelessWidget {
  final Post post;
  final TogglePostReactionBloc togglePostReactionBloc;

  const PostDetailPage({
    Key? key,
    required this.post,
    required this.togglePostReactionBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: togglePostReactionBloc,
        ),
        BlocProvider(
          create: (context) => GetPostCommentsBloc()
            ..add(
              GetPostCommentsEvent.fetch(
                input: GetPostCommentsInput(post: post.id),
              ),
            ),
        ),
        BlocProvider(
          create: (context) => CreatePostCommentBloc(),
        ),
      ],
      child: PostDetailView(post: post),
    );
  }
}

class PostDetailView extends StatelessWidget {
  final Post post;

  const PostDetailView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final isLoggedIn =
        context.watch<AuthBloc>().state is AuthStateAuthenticated;
    return Scaffold(
      appBar: LemonAppBar(
        leading: const LemonBackButton(),
        title: t.post.post,
      ),
      backgroundColor: colorScheme.primary,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.pixels ==
                    notification.metrics.maxScrollExtent) {
                  if (isLoggedIn) {
                    context.read<GetPostCommentsBloc>().add(
                          GetPostCommentsEvent.fetch(
                            input: GetPostCommentsInput(post: post.id),
                          ),
                        );
                  }
                }
              }
              return true;
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Spacing.extraSmall),
                    child: Column(
                      children: [
                        PostDetailCard(
                          post: post,
                        ),
                        SizedBox(height: Spacing.small),
                        Divider(color: colorScheme.outline),
                      ],
                    ),
                  ),
                ),
                if (isLoggedIn)
                  BlocListener<CreatePostCommentBloc, CreatePostCommentState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () => null,
                        success: (newComment) {
                          context.read<GetPostCommentsBloc>().add(
                                GetPostCommentsEvent.refresh(
                                  input: GetPostCommentsInput(
                                    post: post.id,
                                  ),
                                ),
                              );
                        },
                      );
                    },
                    child:
                        BlocBuilder<GetPostCommentsBloc, GetPostCommentsState>(
                      builder: (context, state) {
                        return state.when(
                          loading: () => SliverToBoxAdapter(
                            child: Loading.defaultLoading(context),
                          ),
                          failure: () => SliverToBoxAdapter(
                            child: EmptyList(
                              emptyText: t.common.somethingWrong,
                            ),
                          ),
                          success: (comments) {
                            if (comments.isEmpty) {
                              return const SliverToBoxAdapter();
                            }

                            return SliverList.builder(
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                return PostCommentTile(
                                  comment: comments[index],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(height: Spacing.xLarge * 3),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PostCommentInput(
              onPressSubmit: (text) =>
                  context.read<CreatePostCommentBloc>().add(
                        CreatePostCommentEvent.create(
                          input: CreatePostCommentInput(
                            post: post.id,
                            text: text,
                          ),
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
