// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/application/auth/auth_bloc.dart' as _i25;
import 'package:app/core/data/event/repository/event_repository_impl.dart'
    as _i8;
import 'package:app/core/data/post/newsfeed_repository_impl.dart' as _i13;
import 'package:app/core/data/post/post_repository_impl.dart' as _i15;
import 'package:app/core/data/token/token_repository_impl.dart' as _i18;
import 'package:app/core/data/user/user_repository_impl.dart' as _i20;
import 'package:app/core/data/wallet/wallet_repository_impl.dart' as _i24;
import 'package:app/core/domain/event/event_repository.dart' as _i7;
import 'package:app/core/domain/newsfeed/newsfeed_repository.dart' as _i12;
import 'package:app/core/domain/post/post_repository.dart' as _i14;
import 'package:app/core/domain/token/token_repository.dart' as _i17;
import 'package:app/core/domain/user/user_repository.dart' as _i19;
import 'package:app/core/domain/wallet/wallet_repository.dart' as _i23;
import 'package:app/core/gql.dart' as _i3;
import 'package:app/core/oauth/oauth.dart' as _i4;
import 'package:app/core/service/auth/auth_service.dart' as _i5;
import 'package:app/core/service/badge/badge_service.dart' as _i6;
import 'package:app/core/service/firebase/firebase_service.dart' as _i9;
import 'package:app/core/service/matrix/matrix_service.dart' as _i11;
import 'package:app/core/service/shake/shake_service.dart' as _i16;
import 'package:app/core/service/user/user_service.dart' as _i21;
import 'package:app/core/service/wallet_connect/wallet_connect_service.dart'
    as _i22;
import 'package:app/core/utils/location_utils.dart' as _i10;
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
    gh.lazySingleton<_i6.BadgeService>(() => _i6.BadgeService());
    gh.lazySingleton<_i7.EventRepository>(() => _i8.EventRepositoryImpl());
    gh.lazySingleton<_i9.FirebaseService>(() => _i9.FirebaseService());
    gh.lazySingleton<_i10.LocationUtils>(() => _i10.LocationUtils());
    gh.lazySingleton<_i11.MatrixService>(() => _i11.MatrixService());
    gh.lazySingleton<_i3.MetaverseGQL>(() => _i3.MetaverseGQL());
    gh.lazySingleton<_i12.NewsfeedRepository>(
        () => _i13.NewsfeedRepositoryImpl());
    gh.lazySingleton<_i14.PostRepository>(() => _i15.PostRepositoryImpl());
    gh.lazySingleton<_i16.ShakeService>(() => _i16.ShakeService());
    gh.lazySingleton<_i17.TokenRepository>(() => _i18.TokenRepositoryImpl());
    gh.lazySingleton<_i19.UserRepository>(() => _i20.UserRepositoryImpl());
    gh.lazySingleton<_i21.UserService>(() => _i21.UserService());
    gh.lazySingleton<_i22.WalletConnectService>(
        () => _i22.WalletConnectService());
    gh.lazySingleton<_i23.WalletRepository>(() => _i24.WalletRepositoryImpl());
    gh.lazySingleton<_i25.AuthBloc>(() => _i25.AuthBloc(
          userService: gh<_i21.UserService>(),
          authService: gh<_i5.AuthService>(),
        ));
    return this;
  }
}
