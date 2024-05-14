import 'package:app/core/domain/common/common_repository.dart';
import 'package:app/core/domain/common/entities/common.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

part 'get_all_currencies_bloc.freezed.dart';

class GetAllCurrenciesBloc
    extends Bloc<GetAllCurrenciesEvent, GetAllCurrenciesState> {
  GetAllCurrenciesBloc()
      : super(
          GetAllCurrenciesState(
            isLoading: true,
            currencies: [],
          ),
        ) {
    on<_GetAllCurrenciesEventFetch>(_onFetch);
    add(_GetAllCurrenciesEventFetch());
  }

  void _onFetch(_GetAllCurrenciesEventFetch event, Emitter emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final result = await getIt<CommonRepository>().listAllCurrencies();
    result.fold(
      (l) {
        emit(
          state.copyWith(isLoading: false),
        );
      },
      (currencies) => emit(
        state.copyWith(
          isLoading: false,
          currencies: currencies,
        ),
      ),
    );
  }

  Currency? getCurrencyByCode(String code) {
    return state.currencies.firstWhereOrNull(
      (element) => element.code == code,
    );
  }
}

@freezed
class GetAllCurrenciesEvent with _$GetAllCurrenciesEvent {
  factory GetAllCurrenciesEvent.fetch() = _GetAllCurrenciesEventFetch;
}

@freezed
class GetAllCurrenciesState with _$GetAllCurrenciesState {
  factory GetAllCurrenciesState({
    required bool isLoading,
    required List<Currency> currencies,
  }) = _GetAllCurrenciesState;
}
