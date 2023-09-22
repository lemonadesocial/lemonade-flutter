// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/application/auth/auth_bloc.dart' as _i32;
import 'package:app/core/application/chat/new_chat_bloc/new_chat_bloc.dart'
    as _i16;
import 'package:app/core/data/badge/repository/badge_respository_impl.dart'
    as _i7;
import 'package:app/core/data/event/repository/event_repository_impl.dart'
    as _i10;
import 'package:app/core/data/event/repository/event_ticket_repository_impl.dart'
    as _i12;
import 'package:app/core/data/poap/poap_repository_impl.dart' as _i20;
import 'package:app/core/data/post/newsfeed_repository_impl.dart' as _i18;
import 'package:app/core/data/post/post_repository_impl.dart' as _i22;
import 'package:app/core/data/token/token_repository_impl.dart' as _i25;
import 'package:app/core/data/user/user_repository_impl.dart' as _i27;
import 'package:app/core/data/wallet/wallet_repository_impl.dart' as _i31;
import 'package:app/core/domain/badge/badge_repository.dart' as _i6;
import 'package:app/core/domain/event/event_repository.dart' as _i9;
import 'package:app/core/domain/event/repository/event_ticket_repository.dart'
    as _i11;
import 'package:app/core/domain/newsfeed/newsfeed_repository.dart' as _i17;
import 'package:app/core/domain/poap/poap_repository.dart' as _i19;
import 'package:app/core/domain/post/post_repository.dart' as _i21;
import 'package:app/core/domain/token/token_repository.dart' as _i24;
import 'package:app/core/domain/user/user_repository.dart' as _i26;
import 'package:app/core/domain/wallet/wallet_repository.dart' as _i30;
import 'package:app/core/gql.dart' as _i3;
import 'package:app/core/oauth/oauth.dart' as _i4;
import 'package:app/core/service/auth/auth_service.dart' as _i5;
import 'package:app/core/service/badge/badge_service.dart' as _i8;
import 'package:app/core/service/firebase/firebase_service.dart' as _i13;
import 'package:app/core/service/matrix/matrix_service.dart' as _i15;
import 'package:app/core/service/shake/shake_service.dart' as _i23;
import 'package:app/core/service/user/user_service.dart' as _i28;
import 'package:app/core/service/wallet_connect/wallet_connect_service.dart'
    as _i29;
import 'package:app/core/utils/location_utils.dart' as _i14;
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
    gh.lazySingleton<_i5.AuthService>(() => _i5.AuthService());
    gh.lazySingleton<_i6.BadgeRepository>(() => _i7.BadgeRepositoryImpl());
    gh.lazySingleton<_i8.BadgeService>(() => _i8.BadgeService());
    gh.lazySingleton<_i9.EventRepository>(() => _i10.EventRepositoryImpl());
    gh.lazySingleton<_i11.EventTicketRepository>(
        () => _i12.EventTicketRepositoryImpl());
    gh.lazySingleton<_i13.FirebaseService>(() => _i13.FirebaseService());
    gh.lazySingleton<_i14.LocationUtils>(() => _i14.LocationUtils());
    gh.lazySingleton<_i15.MatrixService>(() => _i15.MatrixService());
    gh.lazySingleton<_i3.MetaverseGQL>(() => _i3.MetaverseGQL());
    gh.lazySingleton<_i16.NewChatBloc>(() => _i16.NewChatBloc());
    gh.lazySingleton<_i17.NewsfeedRepository>(
        () => _i18.NewsfeedRepositoryImpl());
    gh.lazySingleton<_i19.PoapRepository>(() => _i20.PoapRepositoryImpl());
    gh.lazySingleton<_i21.PostRepository>(() => _i22.PostRepositoryImpl());
    gh.lazySingleton<_i23.ShakeService>(() => _i23.ShakeService());
    gh.lazySingleton<_i24.TokenRepository>(() => _i25.TokenRepositoryImpl());
    gh.lazySingleton<_i26.UserRepository>(() => _i27.UserRepositoryImpl());
    gh.lazySingleton<_i28.UserService>(() => _i28.UserService());
    gh.lazySingleton<_i29.WalletConnectService>(
        () => _i29.WalletConnectService());
    gh.lazySingleton<_i3.WalletGQL>(() => _i3.WalletGQL());
    gh.lazySingleton<_i30.WalletRepository>(() => _i31.WalletRepositoryImpl());
    gh.lazySingleton<_i32.AuthBloc>(() => _i32.AuthBloc(
          userService: gh<_i28.UserService>(),
          authService: gh<_i5.AuthService>(),
        ));
    return this;
  }
}
