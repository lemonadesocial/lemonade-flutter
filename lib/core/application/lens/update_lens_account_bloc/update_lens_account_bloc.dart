import 'package:app/core/domain/lens/entities/lens_lemonade_profile.dart';
import 'package:app/core/domain/lens/entities/lens_transaction.dart';
import 'package:app/core/failure.dart';
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart';
import 'package:app/core/utils/gql/gql.dart';
import 'package:app/core/utils/lens_utils.dart';
import 'package:app/graphql/lens/schema.graphql.dart';
import 'package:app/injection/register_module.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/graphql/lens/account/mutation/lens_set_account_metadata.graphql.dart';
import 'dart:async';

part 'update_lens_account_bloc.freezed.dart';

@freezed
class UpdateLensAccountEvent with _$UpdateLensAccountEvent {
  const factory UpdateLensAccountEvent.requestUpdateLensAccount({
    required LensLemonadeProfile lensLemonadeProfile,
  }) = RequestUpdateLensAccount;
}

@freezed
sealed class UpdateLensAccountState with _$UpdateLensAccountState {
  const factory UpdateLensAccountState.initial() = UpdateLensAccountInitial;
  const factory UpdateLensAccountState.loading() = UpdateLensAccountLoading;
  const factory UpdateLensAccountState.success() = UpdateLensAccountSuccess;
  const factory UpdateLensAccountState.failed({
    required Failure failure,
  }) = UpdateLensAccountFailed;
}

class UpdateLensAccountBloc
    extends Bloc<UpdateLensAccountEvent, UpdateLensAccountState> {
  final LensGroveService _lensGroveService;

  UpdateLensAccountBloc(this._lensGroveService)
      : super(const UpdateLensAccountState.initial()) {
    on<RequestUpdateLensAccount>(_onRequestUpdateLensAccount);
  }

  Future<void> _onRequestUpdateLensAccount(
    RequestUpdateLensAccount event,
    Emitter<UpdateLensAccountState> emit,
  ) async {
    try {
      emit(const UpdateLensAccountState.loading());

      final newAccountMetadata =
          event.lensLemonadeProfile.generateLensAccountMetadata();

      final uploadResult =
          await _lensGroveService.uploadJson(newAccountMetadata);

      if (uploadResult == null) {
        throw Exception('Failed to upload metadata');
      }

      final result = await getIt<LensGQL>().client.mutate$SetAccountMetadata(
            Options$Mutation$SetAccountMetadata(
              variables: Variables$Mutation$SetAccountMetadata(
                request: Input$SetAccountMetadataRequest(
                  metadataUri: uploadResult['uri'] ?? '',
                ),
              ),
            ),
          );

      return await result.parsedData?.setAccountMetadata.maybeWhen(
        orElse: () {
          throw Exception('Unknown error');
        },
        selfFundedTransactionRequest: (selfFundedTransactionRequest) {
          // throw Exception('Self funded transaction request');
        },
        sponsoredTransactionRequest: (sponsoredTransactionRequest) {
          // throw Exception('Sponsored transaction request');
        },
        transactionWillFail: (transactionWillFail) {
          throw Exception('Transaction failed: ${transactionWillFail.reason}');
        },
        setAccountMetadataResponse: (response) async {
          final txHash = response.hash;

          final transactionResult =
              await LensUtils.pollTransactionStatus(txHash: txHash);

          if (transactionResult is FailedTransactionStatus) {
            throw Exception(
              'Failed to create username: ${transactionResult.reason}',
            );
          }

          emit(const UpdateLensAccountState.success());
        },
      );
    } catch (error) {
      emit(
        UpdateLensAccountState.failed(
          failure: Failure(message: error.toString()),
        ),
      );
    }
  }
}
