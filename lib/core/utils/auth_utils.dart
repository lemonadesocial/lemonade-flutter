import 'package:app/core/application/auth/auth_bloc.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthUtils {
  static bool isMe(BuildContext context, {required User user}) {
    String? myUserId = context.read<AuthBloc>().state.maybeWhen(
          authenticated: (authSession) => authSession.userId,
          orElse: () => null,
        );
    return user.userId == myUserId;
  }

  static String getUserId(BuildContext context) {
    return context.read<AuthBloc>().state.maybeWhen(
          orElse: () => '',
          authenticated: (authSession) => authSession.userId,
        );
  }
}
