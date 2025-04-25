// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/application/auth/auth_bloc.dart' as _i319;
import 'package:app/core/application/chat/new_chat_bloc/new_chat_bloc.dart'
    as _i860;
import 'package:app/core/application/event/event_datetime_settings_bloc/event_datetime_settings_bloc.dart'
    as _i449;
import 'package:app/core/application/event/event_guest_settings_bloc/event_guest_settings_bloc.dart'
    as _i611;
import 'package:app/core/application/event/event_location_setting_bloc/event_location_setting_bloc.dart'
    as _i971;
import 'package:app/core/application/event/event_subevents_setting_bloc/event_subevents_setting_bloc.dart'
    as _i839;
import 'package:app/core/data/ai/repository/ai_repository_impl.dart' as _i262;
import 'package:app/core/data/applicant/applicant_repository_impl.dart'
    as _i971;
import 'package:app/core/data/badge/repository/badge_respository_impl.dart'
    as _i267;
import 'package:app/core/data/chat/chat_repository_impl.dart' as _i1015;
import 'package:app/core/data/collaborator/collaborator_repository_impl.dart'
    as _i777;
import 'package:app/core/data/community/community_repository_impl.dart'
    as _i394;
import 'package:app/core/data/crypto_ramp/crypto_ramp_repository_impl.dart'
    as _i58;
import 'package:app/core/data/cubejs/cubejs_repository_impl.dart' as _i423;
import 'package:app/core/data/event/repository/event_payment_repository_impl.dart'
    as _i844;
import 'package:app/core/data/event/repository/event_repository_impl.dart'
    as _i412;
import 'package:app/core/data/event/repository/event_reward_repository_impl.dart'
    as _i54;
import 'package:app/core/data/event/repository/event_ticket_repository_impl.dart'
    as _i907;
import 'package:app/core/data/farcaster/farcaster_repository_impl.dart'
    as _i987;
import 'package:app/core/data/lens/lens_repository_impl.dart' as _i197;
import 'package:app/core/data/notification/repository/notification_repository_impl.dart'
    as _i315;
import 'package:app/core/data/payment/payment_repository_impl.dart' as _i139;
import 'package:app/core/data/poap/poap_repository_impl.dart' as _i271;
import 'package:app/core/data/post/newsfeed_repository_impl.dart' as _i834;
import 'package:app/core/data/post/post_repository_impl.dart' as _i821;
import 'package:app/core/data/quest/quest_repository_impl.dart' as _i859;
import 'package:app/core/data/report/repository/report_repository_impl.dart'
    as _i928;
import 'package:app/core/data/reward/reward_repository_impl.dart' as _i981;
import 'package:app/core/data/space/space_repository_impl.dart' as _i88;
import 'package:app/core/data/token-gating/token_gating_repository_impl.dart'
    as _i106;
import 'package:app/core/data/token/token_repository_impl.dart' as _i422;
import 'package:app/core/data/user/user_repository_impl.dart' as _i197;
import 'package:app/core/data/vault/vault_repository_impl.dart' as _i853;
import 'package:app/core/data/wallet/wallet_repository_impl.dart' as _i388;
import 'package:app/core/data/web3/web3_repository_impl.dart' as _i31;
import 'package:app/core/domain/ai/ai_repository.dart' as _i34;
import 'package:app/core/domain/applicant/applicant_repository.dart' as _i309;
import 'package:app/core/domain/badge/badge_repository.dart' as _i934;
import 'package:app/core/domain/chat/chat_repository.dart' as _i739;
import 'package:app/core/domain/collaborator/collaborator_repository.dart'
    as _i106;
import 'package:app/core/domain/community/community_repository.dart' as _i545;
import 'package:app/core/domain/crypto_ramp/crypto_ramp_repository.dart'
    as _i938;
import 'package:app/core/domain/cubejs/cubejs_repository.dart' as _i995;
import 'package:app/core/domain/event/event_repository.dart' as _i441;
import 'package:app/core/domain/event/repository/event_payment_repository.dart'
    as _i234;
import 'package:app/core/domain/event/repository/event_reward_repository.dart'
    as _i110;
import 'package:app/core/domain/event/repository/event_ticket_repository.dart'
    as _i689;
import 'package:app/core/domain/farcaster/farcaster_repository.dart' as _i143;
import 'package:app/core/domain/lens/lens_repository.dart' as _i227;
import 'package:app/core/domain/newsfeed/newsfeed_repository.dart' as _i530;
import 'package:app/core/domain/notification/notification_repository.dart'
    as _i139;
import 'package:app/core/domain/payment/payment_repository.dart' as _i168;
import 'package:app/core/domain/poap/poap_repository.dart' as _i778;
import 'package:app/core/domain/post/post_repository.dart' as _i968;
import 'package:app/core/domain/quest/quest_repository.dart' as _i1056;
import 'package:app/core/domain/report/report_repository.dart' as _i921;
import 'package:app/core/domain/reward/reward_repository.dart' as _i684;
import 'package:app/core/domain/space/space_repository.dart' as _i467;
import 'package:app/core/domain/token-gating/token_gating_repository.dart'
    as _i583;
import 'package:app/core/domain/token/token_repository.dart' as _i722;
import 'package:app/core/domain/user/user_repository.dart' as _i672;
import 'package:app/core/domain/vault/vault_repository.dart' as _i472;
import 'package:app/core/domain/wallet/wallet_repository.dart' as _i691;
import 'package:app/core/domain/web3/web3_repository.dart' as _i347;
import 'package:app/core/oauth/oauth.dart' as _i505;
import 'package:app/core/service/badge/badge_service.dart' as _i459;
import 'package:app/core/service/firebase/firebase_service.dart' as _i1033;
import 'package:app/core/service/lens/lens_grove_service/lens_grove_service.dart'
    as _i179;
import 'package:app/core/service/lens/lens_storage_service/lens_storage_service.dart'
    as _i548;
import 'package:app/core/service/matrix/matrix_service.dart' as _i407;
import 'package:app/core/service/shorebird_codepush_service.dart' as _i380;
import 'package:app/core/service/vault/owner_key/database/owner_keys_database.dart'
    as _i951;
import 'package:app/core/service/wallet/wallet_connect_service.dart' as _i464;
import 'package:app/core/utils/gql/gql.dart' as _i136;
import 'package:app/core/utils/location_utils.dart' as _i139;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i505.AppOauth>(() => _i505.AppOauth());
    gh.lazySingleton<_i136.MetaverseGQL>(() => _i136.MetaverseGQL());
    gh.lazySingleton<_i136.AppGQL>(() => _i136.AppGQL());
    gh.lazySingleton<_i136.WalletGQL>(() => _i136.WalletGQL());
    gh.lazySingleton<_i136.AIGQL>(() => _i136.AIGQL());
    gh.lazySingleton<_i136.AirstackGQL>(() => _i136.AirstackGQL());
    gh.lazySingleton<_i136.LensGQL>(() => _i136.LensGQL());
    gh.lazySingleton<_i139.LocationUtils>(() => _i139.LocationUtils());
    gh.lazySingleton<_i860.NewChatBloc>(() => _i860.NewChatBloc());
    gh.lazySingleton<_i319.AuthBloc>(() => _i319.AuthBloc());
    gh.lazySingleton<_i449.EventDateTimeSettingsBloc>(
        () => _i449.EventDateTimeSettingsBloc());
    gh.lazySingleton<_i971.EventLocationSettingBloc>(
        () => _i971.EventLocationSettingBloc());
    gh.lazySingleton<_i839.EventSubEventsSettingBloc>(
        () => _i839.EventSubEventsSettingBloc());
    gh.lazySingleton<_i380.ShorebirdCodePushService>(
        () => _i380.ShorebirdCodePushService());
    gh.lazySingleton<_i1033.FirebaseService>(() => _i1033.FirebaseService());
    gh.lazySingleton<_i464.WalletConnectService>(
        () => _i464.WalletConnectService());
    gh.lazySingleton<_i407.MatrixService>(() => _i407.MatrixService());
    gh.lazySingleton<_i951.OwnerKeysDatabase>(() => _i951.OwnerKeysDatabase());
    gh.lazySingleton<_i459.BadgeService>(() => _i459.BadgeService());
    gh.lazySingleton<_i179.LensGroveService>(() => _i179.LensGroveService());
    gh.lazySingleton<_i548.LensStorageService>(
        () => _i548.LensStorageService());
    gh.lazySingleton<_i110.EventRewardRepository>(
        () => _i54.EventRewardRepositoryImpl());
    gh.lazySingleton<_i934.BadgeRepository>(() => _i267.BadgeRepositoryImpl());
    gh.lazySingleton<_i689.EventTicketRepository>(
        () => _i907.EventTicketRepositoryImpl());
    gh.lazySingleton<_i938.CryptoRampRepository>(
        () => _i58.CryptoRampRepositoryImpl());
    gh.lazySingleton<_i467.SpaceRepository>(() => _i88.SpaceRepositoryImpl());
    gh.lazySingleton<_i139.NotificationRepository>(
        () => _i315.NotificationRepositoryImpl());
    gh.lazySingleton<_i691.WalletRepository>(
        () => _i388.WalletRepositoryImpl());
    gh.lazySingleton<_i583.TokenGatingRepository>(
        () => _i106.TokenGatingRepositoryImpl());
    gh.lazySingleton<_i530.NewsfeedRepository>(
        () => _i834.NewsfeedRepositoryImpl());
    gh.lazySingleton<_i309.ApplicantRepository>(
        () => _i971.ApplicantRepositoryImpl());
    gh.lazySingleton<_i968.PostRepository>(() => _i821.PostRepositoryImpl());
    gh.lazySingleton<_i168.PaymentRepository>(
        () => _i139.PaymentRepositoryImpl());
    gh.lazySingleton<_i34.AIRepository>(() => _i262.AIRepositoryImpl());
    gh.lazySingleton<_i143.FarcasterRepository>(
        () => _i987.FarcasterRepositoryImpl());
    gh.lazySingleton<_i739.ChatRepository>(() => _i1015.ChatRepositoryImpl());
    gh.lazySingleton<_i106.CollaboratorRepository>(
        () => _i777.CollaboratorRepositoryImpl());
    gh.lazySingleton<_i684.RewardRepository>(
        () => _i981.RewardRepositoryImpl());
    gh.lazySingleton<_i1056.QuestRepository>(() => _i859.QuestRepositoryImpl());
    gh.lazySingleton<_i441.EventRepository>(() => _i412.EventRepositoryImpl());
    gh.lazySingleton<_i227.LensRepository>(() => _i197.LensRepositoryImpl());
    gh.lazySingleton<_i545.CommunityRepository>(
        () => _i394.CommunityRepositoryImpl());
    gh.lazySingleton<_i234.EventPaymentRepository>(
        () => _i844.EventPaymentRepositoryImpl());
    gh.lazySingleton<_i347.Web3Repository>(() => _i31.Web3RepositoryIml());
    gh.lazySingleton<_i921.ReportRepository>(
        () => _i928.ReportRepositoryImpl());
    gh.lazySingleton<_i672.UserRepository>(() => _i197.UserRepositoryImpl());
    gh.lazySingleton<_i722.TokenRepository>(() => _i422.TokenRepositoryImpl());
    gh.lazySingleton<_i472.VaultRepository>(() => _i853.VaultRepositoryImpl());
    gh.lazySingleton<_i778.PoapRepository>(() => _i271.PoapRepositoryImpl());
    gh.lazySingleton<_i995.CubeJsRepository>(
        () => _i423.CubeJsRepositoryImpl());
    gh.lazySingleton<_i611.EventGuestSettingsBloc>(
        () => _i611.EventGuestSettingsBloc(parentEventId: gh<String>()));
    return this;
  }
}
