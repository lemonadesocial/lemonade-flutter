import 'dart:async';

import 'package:app/core/application/lens/create_lens_post_bloc/create_lens_post_bloc.dart';
import 'package:flutter/material.dart';

class CreateLensPostResultListenerWidget extends StatefulWidget {
  final Function()? onSuccess;
  final Function()? onError;

  const CreateLensPostResultListenerWidget({
    super.key,
    this.onSuccess,
    this.onError,
  });

  @override
  State<CreateLensPostResultListenerWidget> createState() =>
      _CreateLensPostResultListenerWidgetState();
}

class _CreateLensPostResultListenerWidgetState
    extends State<CreateLensPostResultListenerWidget> {
  StreamSubscription<bool>? _createPostResultStreamSubscription;

  void _onCreatePostResult(bool result) {
    if (result) {
      widget.onSuccess?.call();
    } else {
      widget.onError?.call();
    }
  }

  @override
  void initState() {
    super.initState();
    _createPostResultStreamSubscription =
        CreateLensPostBloc.createPostResultStream.listen(_onCreatePostResult);
  }

  @override
  void dispose() {
    _createPostResultStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
