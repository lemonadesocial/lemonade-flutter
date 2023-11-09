// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/client/chat_ai_client.dart' as _i9;
import 'package:app/core/application/auth/auth_bloc.dart' as _i5;
import 'package:app/core/application/chat/new_chat_bloc/new_chat_bloc.dart'
    as _i21;
import 'package:app/core/data/badge/repository/badge_respository_impl.dart'
    as _i7;
import 'package:app/core/data/community/community_repository_impl.dart' as _i11;
import 'package:app/core/data/event/repository/event_payment_repository_impl.dart'
    as _i13;
import 'package:app/core/data/event/repository/event_repository_impl.dart'
    as _i15;
import 'package:app/core/data/event/repository/event_ticket_repository_impl.dart'
    as _i17;
import 'package:app/core/data/notification/repository/notification_repository_impl.dart'
    as _i25;
import 'package:app/core/data/payment/payment_repository_impl.dart' as _i27;
import 'package:app/core/data/poap/poap_repository_impl.dart' as _i29;
import 'package:app/core/data/post/newsfeed_repository_impl.dart' as _i23;
import 'package:app/core/data/post/post_repository_impl.dart' as _i31;
import 'package:app/core/data/report/repository/report_repository_impl.dart'
    as _i33;
import 'package:app/core/data/token/token_repository_impl.dart' as _i37;
import 'package:app/core/data/user/user_repository_impl.dart' as _i39;
import 'package:app/core/data/wallet/wallet_repository_impl.dart' as _i42;
import 'package:app/core/domain/badge/badge_repository.dart' as _i6;
import 'package:app/core/domain/community/community_repository.dart' as _i10;
import 'package:app/core/domain/event/event_repository.dart' as _i14;
import 'package:app/core/domain/event/repository/event_payment_repository.dart'
    as _i12;
import 'package:app/core/domain/event/repository/event_ticket_repository.dart'
    as _i16;
import 'package:app/core/domain/newsfeed/newsfeed_repository.dart' as _i22;
import 'package:app/core/domain/notification/notification_repository.dart'
    as _i24;
import 'package:app/core/domain/payment/payment_repository.dart' as _i26;
import 'package:app/core/domain/poap/poap_repository.dart' as _i28;
import 'package:app/core/domain/post/post_repository.dart' as _i30;
import 'package:app/core/domain/report/report_repository.dart' as _i32;
import 'package:app/core/domain/token/token_repository.dart' as _i36;
import 'package:app/core/domain/user/user_repository.dart' as _i38;
import 'package:app/core/domain/wallet/wallet_repository.dart' as _i41;
import 'package:app/core/oauth/oauth.dart' as _i4;
import 'package:app/core/service/badge/badge_service.dart' as _i8;
import 'package:app/core/service/firebase/firebase_service.dart' as _i18;
import 'package:app/core/service/matrix/matrix_service.dart' as _i20;
import 'package:app/core/service/shake/shake_service.dart' as _i34;
import 'package:app/core/service/shorebird_codepush_service.dart' as _i35;
import 'package:app/core/service/wallet/wallet_connect_service.dart' as _i40;
import 'package:app/core/utils/gql/gql.dart' as _i3;
import 'package:app/core/utils/location_utils.dart' as _i19;
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
    gh.lazySingleton<_i3.AppGQL>(() => _i3.AppGQL());
    gh.lazySingleton<_i4.AppOauth>(() => _i4.AppOauth());
    gh.lazySingleton<_i5.AuthBloc>(() => _i5.AuthBloc());
    gh.lazySingleton<_i6.BadgeRepository>(() => _i7.BadgeRepositoryImpl());
    gh.lazySingleton<_i8.BadgeService>(() => _i8.BadgeService());
    gh.lazySingleton<_i9.ChatAIClient>(() => _i9.ChatAIClient());
    gh.lazySingleton<_i10.CommunityRepository>(
        () => _i11.CommunityRepositoryImpl());
    gh.lazySingleton<_i12.EventPaymentRepository>(
        () => _i13.EventPaymentRepositoryImpl());
    gh.lazySingleton<_i14.EventRepository>(() => _i15.EventRepositoryImpl());
    gh.lazySingleton<_i16.EventTicketRepository>(
        () => _i17.EventTicketRepositoryImpl());
    gh.lazySingleton<_i18.FirebaseService>(() => _i18.FirebaseService());
    gh.lazySingleton<_i19.LocationUtils>(() => _i19.LocationUtils());
    gh.lazySingleton<_i20.MatrixService>(() => _i20.MatrixService());
    gh.lazySingleton<_i3.MetaverseGQL>(() => _i3.MetaverseGQL());
    gh.lazySingleton<_i21.NewChatBloc>(() => _i21.NewChatBloc());
    gh.lazySingleton<_i22.NewsfeedRepository>(
        () => _i23.NewsfeedRepositoryImpl());
    gh.lazySingleton<_i24.NotificationRepository>(
        () => _i25.NotificationRepositoryImpl());
    gh.lazySingleton<_i26.PaymentRepository>(
        () => _i27.PaymentRepositoryImpl());
    gh.lazySingleton<_i28.PoapRepository>(() => _i29.PoapRepositoryImpl());
    gh.lazySingleton<_i30.PostRepository>(() => _i31.PostRepositoryImpl());
    gh.lazySingleton<_i32.ReportRepository>(() => _i33.ReportRepositoryImpl());
    gh.lazySingleton<_i34.ShakeService>(() => _i34.ShakeService());
    gh.lazySingleton<_i35.ShorebirdCodePushService>(
        () => _i35.ShorebirdCodePushService());
    gh.lazySingleton<_i36.TokenRepository>(() => _i37.TokenRepositoryImpl());
    gh.lazySingleton<_i38.UserRepository>(() => _i39.UserRepositoryImpl());
    gh.lazySingleton<_i40.WalletConnectService>(
        () => _i40.WalletConnectService());
    gh.lazySingleton<_i3.WalletGQL>(() => _i3.WalletGQL());
    gh.lazySingleton<_i41.WalletRepository>(() => _i42.WalletRepositoryImpl());
    return this;
  }
}
