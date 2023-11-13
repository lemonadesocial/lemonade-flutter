import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Displays a loading dialog which reacts to the given [future]. The dialog
/// will be dismissed and the value will be returned when the future completes.
/// If an error occured, then [onError] will be called and this method returns
/// null. Set [title] and [backLabel] to controll the look and feel or set
/// [LoadingDialog.defaultTitle], [LoadingDialog.defaultBackLabel] and
/// [LoadingDialog.defaultOnError] to have global preferences.
Future<LoadingDialogResult<T>> showFutureLoadingDialog<T>({
  required BuildContext context,
  required Future<T> Function() future,
  String? title,
  String? backLabel,
  String Function(dynamic exception)? onError,
  bool barrierDismissible = false,
}) async {
  final dialog = LoadingDialog<T>(
    future: future,
    title: title,
    backLabel: backLabel,
    onError: onError,
  );
  final result = dialog.isCupertinoStyle
      ? await showCupertinoDialog<LoadingDialogResult<T>>(
          barrierDismissible: barrierDismissible,
          context: context,
          builder: (BuildContext context) => dialog,
        )
      : await showDialog<LoadingDialogResult<T>>(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: (BuildContext context) => dialog,
        );
  return result ??
      LoadingDialogResult<T>(
        error: Exception('FutureDialog canceled'),
        stackTrace: StackTrace.current,
      );
}

class LoadingDialog<T> extends StatefulWidget {
  final String? title;
  final String? backLabel;
  final Future<T> Function() future;
  final String Function(dynamic exception)? onError;

  static String defaultTitle = 'Loading... Please Wait!';
  static String defaultBackLabel = 'Back';
  // ignore: prefer_function_declarations_over_variables
  static String Function(dynamic exception) defaultOnError =
      (exception) => exception.toString();

  bool get isCupertinoStyle => !kIsWeb && Platform.isIOS;

  const LoadingDialog({
    Key? key,
    required this.future,
    this.title,
    this.onError,
    this.backLabel,
  }) : super(key: key);
  @override
  LoadingDialogState<T> createState() => LoadingDialogState<T>();
}

class LoadingDialogState<T> extends State<LoadingDialog> {
  dynamic exception;
  StackTrace? stackTrace;

  @override
  void initState() {
    super.initState();
    widget.future().then(
          (result) => Navigator.of(context)
              .pop<LoadingDialogResult<T>>(LoadingDialogResult(result: result)),
          onError: (e, s) => setState(
            () {
              exception = e;
              stackTrace = s;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final titleLabel = exception != null
        ? widget.onError?.call(exception) ??
            LoadingDialog.defaultOnError(exception)
        : widget.title ?? LoadingDialog.defaultTitle;
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: exception == null
              ? const CircularProgressIndicator.adaptive()
              : const Icon(
                  Icons.error_outline_outlined,
                  color: Colors.red,
                ),
        ),
        Expanded(
          child: Text(
            titleLabel,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    if (widget.isCupertinoStyle) {
      return CupertinoAlertDialog(
        content: content,
        actions: [
          if (exception != null)
            CupertinoDialogAction(
              onPressed: Navigator.of(context).pop,
              child: Text(widget.backLabel ?? LoadingDialog.defaultBackLabel),
            ),
        ],
      );
    }
    return AlertDialog(
      content: content,
      actions: [
        if (exception != null)
          TextButton(
            onPressed: () => Navigator.of(context).pop<LoadingDialogResult<T>>(
              LoadingDialogResult(
                error: exception,
                stackTrace: stackTrace,
              ),
            ),
            child: Text(widget.backLabel ?? LoadingDialog.defaultBackLabel),
          ),
      ],
    );
  }
}

class LoadingDialogResult<T> {
  final T? result;
  final dynamic error;
  final StackTrace? stackTrace;

  LoadingDialogResult({this.result, this.error, this.stackTrace});
}
