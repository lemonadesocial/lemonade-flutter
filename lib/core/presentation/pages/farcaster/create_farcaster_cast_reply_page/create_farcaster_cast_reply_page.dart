import 'package:app/core/application/farcaster/create_farcaster_cast_bloc/create_farcaster_cast_bloc.dart';
import 'package:app/core/domain/farcaster/entities/airstack_farcaster_cast.dart';
import 'package:app/core/domain/farcaster/farcaster_repository.dart';
import 'package:app/core/presentation/pages/farcaster/create_farcaster_cast_page/widgets/create_cast_bottom_bar/create_farcaster_editor.dart';
import 'package:app/core/presentation/pages/farcaster/widgets/farcaster_cast_item_widget/farcaster_cast_item_widget.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/common/button/linear_gradient_button_widget.dart';
import 'package:app/core/presentation/widgets/future_loading_dialog.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/graphql/backend/farcaster/mutation/create_cast.graphql.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
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
class CreateFarcasterCastReplyPage extends StatelessWidget {
  final AirstackFarcasterCast cast;
  const CreateFarcasterCastReplyPage({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateFarcasterCastBloc(),
      child: _View(cast: cast),
    );
  }
}

class _View extends StatefulWidget {
  const _View({
    required this.cast,
  });

  final AirstackFarcasterCast cast;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  bool mentionSuggestionVisible = false;
  final controller = ScrollController();

  Future<void> submitCreateReply() async {
    final t = Translations.of(context);
    final payload = context.read<CreateFarcasterCastBloc>().state.payload;
    final mentions = payload.mentions.map((item) => item.fid).toList();
    final mentionsPositions =
        payload.mentions.map((item) => item.position).toList();
    final response = await showFutureLoadingDialog(
      context: context,
      future: () async {
        return await getIt<FarcasterRepository>().createCast(
          input: Variables$Mutation$CreateCast(
            text: payload.messageWithoutMentions,
            parentCast: Input$ParentCastInput(
              fid: double.parse(widget.cast.fid ?? '0'),
              hash: widget.cast.hash?.replaceFirst('0x', "") ?? '',
            ),
            mentions: mentions,
            mentionsPositions: mentionsPositions,
          ),
        );
      },
    );
    response.result?.fold((l) {
      return null;
    }, (success) {
      if (success) {
        SnackBarUtils.showSuccess(
          message: t.farcaster.castCreatedSuccess,
        );
        AutoRouter.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
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
                      child: FarcasterCastItemWidget(
                        cast: widget.cast,
                        showActions: false,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text.rich(
                        TextSpan(
                          text: t.farcaster.replyingTo,
                          children: [
                            TextSpan(
                              text: " @${widget.cast.castedBy?.profileName}",
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
                        child: CreateFarcasterEditor(
                          onSuggestionVisibleChanged: (visible) {
                            if (visible) {
                              controller.animateTo(
                                controller.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
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
                  BlocBuilder<CreateFarcasterCastBloc,
                      CreateFarcasterCastState>(
                    builder: (context, state) => SizedBox(
                      width: 105.w,
                      height: Sizing.large,
                      child: Opacity(
                        opacity: state.isValid ? 1 : 0.5,
                        child: LinearGradientButton.primaryButton(
                          onTap: () {
                            if (!state.isValid) {
                              return;
                            }
                            submitCreateReply();
                          },
                          label: t.farcaster.cast,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
