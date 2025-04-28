import 'package:app/core/application/lens/create_lens_post_bloc/create_lens_post_bloc.dart';
import 'package:app/core/domain/lens/entities/lens_post.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/presentation/pages/lens/page/create_lens_post_page/widgets/create_lens_post_editor.dart';
import 'package:app/core/presentation/pages/lens/widget/lens_post_feed/widgets/lenst_post_feed_item_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/i18n/i18n.g.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/sizing.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CreateLensPostReplyPage extends StatelessWidget {
  final LensPost post;
  const CreateLensPostReplyPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateLensPostBloc(
        getIt<LensRepository>(),
        getIt<LensGroveService>(),
      ),
      child: _View(post: post),
    );
  }
}

class _View extends StatefulWidget {
  const _View({
    required this.post,
  });

  final LensPost post;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  bool mentionSuggestionVisible = false;
  final controller = ScrollController();
  final editorController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    editorController.addListener(_validate);
  }

  @override
  void dispose() {
    controller.dispose();
    editorController.dispose();
    super.dispose();
  }

  void _validate() {
    final content = editorController.text.trim();
    setState(() {
      _isValid = content.isNotEmpty;
    });
  }

  Future<void> submitCreateReply() async {
    context.read<CreateLensPostBloc>().add(
          CreateLensPostEvent.createPost(
            content: editorController.text.trim(),
            commentOn: Input$ReferencingPostInput(
              post: widget.post.id ?? '',
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return BlocListener<CreateLensPostBloc, CreateLensPostState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          failed: (failure) {
            SnackBarUtils.showError(message: failure.message);
          },
          success: (txHash) {
            AutoRouter.of(context).pop();
          },
        );
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: const LemonAppBar(),
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Spacing.xSmall),
                      child: CustomScrollView(
                        controller: controller,
                        slivers: [
                          SliverToBoxAdapter(
                            child: LensPostFeedItemWidget(
                              post: widget.post,
                              showActions: false,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Text.rich(
                              TextSpan(
                                text: t.farcaster.replyingTo,
                                children: [
                                  TextSpan(
                                    text:
                                        " @${widget.post.author?.username?.localName}",
                                    style: TextStyle(
                                      color: LemonColor.paleViolet,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              child: CreateLensPostEditor(
                                onContentChanged: (content) {
                                  editorController.text = content;
                                },
                                onSuggestionVisibleChanged: (visible) {
                                  if (visible) {
                                    controller.animateTo(
                                      controller.position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOut,
                                    );
                                  }
                                  setState(() {
                                    mentionSuggestionVisible = visible;
                                  });
                                },
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 200.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.all(Spacing.smMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 72.w,
                          height: Sizing.medium,
                          child: Opacity(
                            opacity: _isValid ? 1 : 0.5,
                            child: LinearGradientButton.primaryButton(
                              onTap: () {
                                if (!_isValid) {
                                  return;
                                }
                                submitCreateReply();
                              },
                              label: t.common.actions.post,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<CreateLensPostBloc, CreateLensPostState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                loading: () => Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Loading.defaultLoading(context),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
