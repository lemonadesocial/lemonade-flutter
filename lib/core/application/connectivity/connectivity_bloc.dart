import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity_bloc.freezed.dart';

part 'connectivity_state.dart';

class ConnectivityBloc extends Cubit<ConnectivityState> {
  ConnectivityBloc() : super(const ConnectivityState.initial());

  void onConnectivityStatusChange(bool isConnected) {
    emit(
      isConnected
          ? const ConnectivityState.connected()
          : const ConnectivityState.notConnected(),
    );
  }
}
