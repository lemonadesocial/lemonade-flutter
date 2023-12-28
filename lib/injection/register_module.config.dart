// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/application/auth/auth_bloc.dart' as _i7;
import 'package:app/core/application/chat/new_chat_bloc/new_chat_bloc.dart'
    as _i26;
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart'
    as _i15;
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart'
    as _i16;
import 'package:app/core/data/ai/repository/ai_repository_impl.dart' as _i5;
import 'package:app/core/data/badge/repository/badge_respository_impl.dart'
    as _i9;
import 'package:app/core/data/community/community_repository_impl.dart' as _i12;
import 'package:app/core/data/crypto_ramp/crypto_ramp_repository_impl.dart'
    as _i14;
import 'package:app/core/data/event/repository/event_payment_repository_impl.dart'
    as _i18;
import 'package:app/core/data/event/repository/event_repository_impl.dart'
    as _i20;
import 'package:app/core/data/event/repository/event_ticket_repository_impl.dart'
    as _i22;
import 'package:app/core/data/notification/repository/notification_repository_impl.dart'
    as _i30;
import 'package:app/core/data/payment/payment_repository_impl.dart' as _i33;
import 'package:app/core/data/poap/poap_repository_impl.dart' as _i35;
import 'package:app/core/data/post/newsfeed_repository_impl.dart' as _i28;
import 'package:app/core/data/post/post_repository_impl.dart' as _i37;
import 'package:app/core/data/report/repository/report_repository_impl.dart'
    as _i39;
import 'package:app/core/data/token/token_repository_impl.dart' as _i43;
import 'package:app/core/data/user/user_repository_impl.dart' as _i45;
import 'package:app/core/data/vault/vault_repository_impl.dart' as _i47;
import 'package:app/core/data/wallet/wallet_repository_impl.dart' as _i50;
import 'package:app/core/data/web3/web3_repository_impl.dart' as _i52;
import 'package:app/core/domain/ai/ai_repository.dart' as _i4;
import 'package:app/core/domain/badge/badge_repository.dart' as _i8;
import 'package:app/core/domain/community/community_repository.dart' as _i11;
import 'package:app/core/domain/crypto_ramp/crypto_ramp_repository.dart'
    as _i13;
import 'package:app/core/domain/event/event_repository.dart' as _i19;
import 'package:app/core/domain/event/repository/event_payment_repository.dart'
    as _i17;
import 'package:app/core/domain/event/repository/event_ticket_repository.dart'
    as _i21;
import 'package:app/core/domain/newsfeed/newsfeed_repository.dart' as _i27;
import 'package:app/core/domain/notification/notification_repository.dart'
    as _i29;
import 'package:app/core/domain/payment/payment_repository.dart' as _i32;
import 'package:app/core/domain/poap/poap_repository.dart' as _i34;
import 'package:app/core/domain/post/post_repository.dart' as _i36;
import 'package:app/core/domain/report/report_repository.dart' as _i38;
import 'package:app/core/domain/token/token_repository.dart' as _i42;
import 'package:app/core/domain/user/user_repository.dart' as _i44;
import 'package:app/core/domain/vault/vault_repository.dart' as _i46;
import 'package:app/core/domain/wallet/wallet_repository.dart' as _i49;
import 'package:app/core/domain/web3/web3_repository.dart' as _i51;
import 'package:app/core/oauth/oauth.dart' as _i6;
import 'package:app/core/service/badge/badge_service.dart' as _i10;
import 'package:app/core/service/firebase/firebase_service.dart' as _i23;
import 'package:app/core/service/matrix/matrix_service.dart' as _i25;
import 'package:app/core/service/shake/shake_service.dart' as _i40;
import 'package:app/core/service/shorebird_codepush_service.dart' as _i41;
import 'package:app/core/service/vault/owner_key/database/owner_keys_database.dart'
    as _i31;
import 'package:app/core/service/wallet/wallet_connect_service.dart' as _i48;
import 'package:app/core/utils/gql/gql.dart' as _i3;
import 'package:app/core/utils/location_utils.dart' as _i24;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AIGQL>(() => _i3.AIGQL());
    gh.lazySingleton<_i4.AIRepository>(() => _i5.AIRepositoryImpl());
    gh.lazySingleton<_i3.AppGQL>(() => _i3.AppGQL());
    gh.lazySingleton<_i6.AppOauth>(() => _i6.AppOauth());
    gh.lazySingleton<_i7.AuthBloc>(() => _i7.AuthBloc());
    gh.lazySingleton<_i8.BadgeRepository>(() => _i9.BadgeRepositoryImpl());
    gh.lazySingleton<_i10.BadgeService>(() => _i10.BadgeService());
    gh.lazySingleton<_i11.CommunityRepository>(
        () => _i12.CommunityRepositoryImpl());
    gh.lazySingleton<_i13.CryptoRampRepository>(
        () => _i14.CryptoRampRepositoryImpl());
    gh.lazySingleton<_i15.EventDateTimeSettingsBloc>(
        () => _i15.EventDateTimeSettingsBloc());
    gh.lazySingleton<_i16.EventLocationSettingBloc>(
        () => _i16.EventLocationSettingBloc());
    gh.lazySingleton<_i17.EventPaymentRepository>(
        () => _i18.EventPaymentRepositoryImpl());
    gh.lazySingleton<_i19.EventRepository>(() => _i20.EventRepositoryImpl());
    gh.lazySingleton<_i21.EventTicketRepository>(
        () => _i22.EventTicketRepositoryImpl());
    gh.lazySingleton<_i23.FirebaseService>(() => _i23.FirebaseService());
    gh.lazySingleton<_i24.LocationUtils>(() => _i24.LocationUtils());
    gh.lazySingleton<_i25.MatrixService>(() => _i25.MatrixService());
    gh.lazySingleton<_i3.MetaverseGQL>(() => _i3.MetaverseGQL());
    gh.lazySingleton<_i26.NewChatBloc>(() => _i26.NewChatBloc());
    gh.lazySingleton<_i27.NewsfeedRepository>(
        () => _i28.NewsfeedRepositoryImpl());
    gh.lazySingleton<_i29.NotificationRepository>(
        () => _i30.NotificationRepositoryImpl());
    gh.lazySingleton<_i31.OwnerKeysDatabase>(() => _i31.OwnerKeysDatabase());
    gh.lazySingleton<_i32.PaymentRepository>(
        () => _i33.PaymentRepositoryImpl());
    gh.lazySingleton<_i34.PoapRepository>(() => _i35.PoapRepositoryImpl());
    gh.lazySingleton<_i36.PostRepository>(() => _i37.PostRepositoryImpl());
    gh.lazySingleton<_i38.ReportRepository>(() => _i39.ReportRepositoryImpl());
    gh.lazySingleton<_i40.ShakeService>(() => _i40.ShakeService());
    gh.lazySingleton<_i41.ShorebirdCodePushService>(
        () => _i41.ShorebirdCodePushService());
    gh.lazySingleton<_i42.TokenRepository>(() => _i43.TokenRepositoryImpl());
    gh.lazySingleton<_i44.UserRepository>(() => _i45.UserRepositoryImpl());
    gh.lazySingleton<_i46.VaultRepository>(() => _i47.VaultRepositoryImpl());
    gh.lazySingleton<_i48.WalletConnectService>(
        () => _i48.WalletConnectService());
    gh.lazySingleton<_i3.WalletGQL>(() => _i3.WalletGQL());
    gh.lazySingleton<_i49.WalletRepository>(() => _i50.WalletRepositoryImpl());
    gh.lazySingleton<_i51.Web3Repository>(() => _i52.Web3RepositoryIml());
    return this;
  }
}
