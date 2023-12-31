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
    as _i25;
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart'
    as _i13;
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart'
    as _i14;
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart'
    as _i15;
import 'package:app/core/data/ai/repository/ai_repository_impl.dart' as _i5;
import 'package:app/core/data/badge/repository/badge_respository_impl.dart'
    as _i9;
import 'package:app/core/data/community/community_repository_impl.dart' as _i12;
import 'package:app/core/data/event/repository/event_payment_repository_impl.dart'
    as _i17;
import 'package:app/core/data/event/repository/event_repository_impl.dart'
    as _i19;
import 'package:app/core/data/event/repository/event_ticket_repository_impl.dart'
    as _i21;
import 'package:app/core/data/notification/repository/notification_repository_impl.dart'
    as _i29;
import 'package:app/core/data/payment/payment_repository_impl.dart' as _i32;
import 'package:app/core/data/poap/poap_repository_impl.dart' as _i34;
import 'package:app/core/data/post/newsfeed_repository_impl.dart' as _i27;
import 'package:app/core/data/post/post_repository_impl.dart' as _i36;
import 'package:app/core/data/report/repository/report_repository_impl.dart'
    as _i38;
import 'package:app/core/data/token/token_repository_impl.dart' as _i42;
import 'package:app/core/data/user/user_repository_impl.dart' as _i44;
import 'package:app/core/data/vault/vault_repository_impl.dart' as _i46;
import 'package:app/core/data/wallet/wallet_repository_impl.dart' as _i49;
import 'package:app/core/data/web3/web3_repository_impl.dart' as _i51;
import 'package:app/core/domain/ai/ai_repository.dart' as _i4;
import 'package:app/core/domain/badge/badge_repository.dart' as _i8;
import 'package:app/core/domain/community/community_repository.dart' as _i11;
import 'package:app/core/domain/event/event_repository.dart' as _i18;
import 'package:app/core/domain/event/repository/event_payment_repository.dart'
    as _i16;
import 'package:app/core/domain/event/repository/event_ticket_repository.dart'
    as _i20;
import 'package:app/core/domain/newsfeed/newsfeed_repository.dart' as _i26;
import 'package:app/core/domain/notification/notification_repository.dart'
    as _i28;
import 'package:app/core/domain/payment/payment_repository.dart' as _i31;
import 'package:app/core/domain/poap/poap_repository.dart' as _i33;
import 'package:app/core/domain/post/post_repository.dart' as _i35;
import 'package:app/core/domain/report/report_repository.dart' as _i37;
import 'package:app/core/domain/token/token_repository.dart' as _i41;
import 'package:app/core/domain/user/user_repository.dart' as _i43;
import 'package:app/core/domain/vault/vault_repository.dart' as _i45;
import 'package:app/core/domain/wallet/wallet_repository.dart' as _i48;
import 'package:app/core/domain/web3/web3_repository.dart' as _i50;
import 'package:app/core/oauth/oauth.dart' as _i6;
import 'package:app/core/service/badge/badge_service.dart' as _i10;
import 'package:app/core/service/firebase/firebase_service.dart' as _i22;
import 'package:app/core/service/matrix/matrix_service.dart' as _i24;
import 'package:app/core/service/shake/shake_service.dart' as _i39;
import 'package:app/core/service/shorebird_codepush_service.dart' as _i40;
import 'package:app/core/service/vault/owner_key/database/owner_keys_database.dart'
    as _i30;
import 'package:app/core/service/wallet/wallet_connect_service.dart' as _i47;
import 'package:app/core/utils/gql/gql.dart' as _i3;
import 'package:app/core/utils/location_utils.dart' as _i23;
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
    gh.lazySingleton<_i13.EventDateTimeSettingsBloc>(
        () => _i13.EventDateTimeSettingsBloc());
    gh.lazySingleton<_i14.EventGuestSettingsBloc>(
        () => _i14.EventGuestSettingsBloc());
    gh.lazySingleton<_i15.EventLocationSettingBloc>(
        () => _i15.EventLocationSettingBloc());
    gh.lazySingleton<_i16.EventPaymentRepository>(
        () => _i17.EventPaymentRepositoryImpl());
    gh.lazySingleton<_i18.EventRepository>(() => _i19.EventRepositoryImpl());
    gh.lazySingleton<_i20.EventTicketRepository>(
        () => _i21.EventTicketRepositoryImpl());
    gh.lazySingleton<_i22.FirebaseService>(() => _i22.FirebaseService());
    gh.lazySingleton<_i23.LocationUtils>(() => _i23.LocationUtils());
    gh.lazySingleton<_i24.MatrixService>(() => _i24.MatrixService());
    gh.lazySingleton<_i3.MetaverseGQL>(() => _i3.MetaverseGQL());
    gh.lazySingleton<_i25.NewChatBloc>(() => _i25.NewChatBloc());
    gh.lazySingleton<_i26.NewsfeedRepository>(
        () => _i27.NewsfeedRepositoryImpl());
    gh.lazySingleton<_i28.NotificationRepository>(
        () => _i29.NotificationRepositoryImpl());
    gh.lazySingleton<_i30.OwnerKeysDatabase>(() => _i30.OwnerKeysDatabase());
    gh.lazySingleton<_i31.PaymentRepository>(
        () => _i32.PaymentRepositoryImpl());
    gh.lazySingleton<_i33.PoapRepository>(() => _i34.PoapRepositoryImpl());
    gh.lazySingleton<_i35.PostRepository>(() => _i36.PostRepositoryImpl());
    gh.lazySingleton<_i37.ReportRepository>(() => _i38.ReportRepositoryImpl());
    gh.lazySingleton<_i39.ShakeService>(() => _i39.ShakeService());
    gh.lazySingleton<_i40.ShorebirdCodePushService>(
        () => _i40.ShorebirdCodePushService());
    gh.lazySingleton<_i41.TokenRepository>(() => _i42.TokenRepositoryImpl());
    gh.lazySingleton<_i43.UserRepository>(() => _i44.UserRepositoryImpl());
    gh.lazySingleton<_i45.VaultRepository>(() => _i46.VaultRepositoryImpl());
    gh.lazySingleton<_i47.WalletConnectService>(
        () => _i47.WalletConnectService());
    gh.lazySingleton<_i3.WalletGQL>(() => _i3.WalletGQL());
    gh.lazySingleton<_i48.WalletRepository>(() => _i49.WalletRepositoryImpl());
    gh.lazySingleton<_i50.Web3Repository>(() => _i51.Web3RepositoryIml());
    return this;
  }
}
