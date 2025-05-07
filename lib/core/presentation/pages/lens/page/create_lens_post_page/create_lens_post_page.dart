import 'package:app/core/application/lens/create_lens_post_bloc/create_lens_post_bloc.dart';
import 'package:app/core/domain/lens/lens_repository.dart';
import 'package:app/core/domain/space/entities/space.dart';
import 'package:app/core/presentation/pages/lens/page/create_lens_post_page/widgets/create_lens_post_bottom_bar.dart';
import 'package:app/core/presentation/pages/lens/page/create_lens_post_page/widgets/create_lens_post_editor.dart';
import 'package:app/core/presentation/widgets/common/appbar/lemon_appbar_widget.dart';
import 'package:app/core/presentation/widgets/loading_widget.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/snackbar_utils.dart';
import 'package:app/injection/register_module.dart';
import 'package:app/theme/spacing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CreateLensPostPage extends StatelessWidget {
  const CreateLensPostPage({
    super.key,
    required this.space,
  });

  final Space space;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateLensPostBloc(
        getIt<LensRepository>(),
        getIt<LensGroveService>(),
      ),
      child: CreateLensPostPageView(space: space),
    );
  }
}

class CreateLensPostPageView extends StatefulWidget {
  const CreateLensPostPageView({
    super.key,
    required this.space,
  });

  final Space space;

  @override
  State<CreateLensPostPageView> createState() => _CreateLensPostPageViewState();
}

class _CreateLensPostPageViewState extends State<CreateLensPostPageView> {
  final _editorController = TextEditingController();

  Future<void> submitCreatePost() async {
    context.read<CreateLensPostBloc>().add(
          CreateLensPostEvent.createPost(
            content: _editorController.text,
            lensFeedId: widget.space.lensFeedId ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateLensPostBloc, CreateLensPostState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          success: (txHash) {
            SnackBarUtils.showSuccess(message: 'Post successfully created!');
            AutoRouter.of(context).pop(true);
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
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Spacing.medium,
                              ),
                              child: SizedBox(
                                child: CreateLensPostEditor(
                                  onContentChanged: (message) {
                                    _editorController.text = message;
                                  },
                                ),
                              ),
                            ),
                          ),
                          // SliverToBoxAdapter(
                          //   child: _LensEventThumbnail(event: widget.event),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  CreateLensPostBottomBar(
                    controller: _editorController,
                    onSubmit: () {
                      FocusScope.of(context).unfocus();
                      submitCreatePost();
                    },
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

// class _LensEventThumbnail extends StatelessWidget {
//   final Event event;
//   const _LensEventThumbnail({
//     required this.event,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final t = Translations.of(context);

//     return ClipRRect(
//       borderRadius: BorderRadius.circular(LemonRadius.xSmall),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(LemonRadius.xSmall),
//           border: Border.all(color: colorScheme.outline),
//         ),
//         child: Column(
//           children: [
//             LemonNetworkImage(
//               width: double.infinity,
//               height: 180.w,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(LemonRadius.xSmall),
//                 topLeft: Radius.circular(LemonRadius.xSmall),
//               ),
//               imageUrl: "${AppConfig.webUrl}/api/og/event?id=${event.id ?? ''}",
//               placeholder: ImagePlaceholder.eventCard(),
//             ),
//             Container(
//               padding: EdgeInsets.all(Spacing.superExtraSmall),
//               decoration: BoxDecoration(
//                 color: LemonColor.atomicBlack,
//                 borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(LemonRadius.xSmall),
//                   bottomLeft: Radius.circular(LemonRadius.xSmall),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: LemonOutlineButton(
//                       label: t.farcaster.moreInfo,
//                     ),
//                   ),
//                   SizedBox(
//                     width: Spacing.superExtraSmall,
//                   ),
//                   Expanded(
//                     child: LemonOutlineButton(
//                       label: t.farcaster.viewEvent,
//                       trailing: Assets.icons.icExpand.svg(
//                         width: 12.w,
//                         height: 12.w,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
