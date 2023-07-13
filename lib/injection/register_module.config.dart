// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/application/auth/auth_bloc.dart' as _i17;
import 'package:app/core/data/event/repository/event_repository_impl.dart'
    as _i6;
import 'package:app/core/data/post/post_repository_impl.dart' as _i8;
import 'package:app/core/data/token/token_repository_impl.dart' as _i10;
import 'package:app/core/data/user/user_repository_impl.dart' as _i12;
import 'package:app/core/data/wallet/wallet_repository_impl.dart' as _i16;
import 'package:app/core/domain/event/event_repository.dart' as _i5;
import 'package:app/core/domain/post/post_repository.dart' as _i7;
import 'package:app/core/domain/token/token_repository.dart' as _i9;
import 'package:app/core/domain/user/user_repository.dart' as _i11;
import 'package:app/core/domain/wallet/wallet_repository.dart' as _i15;
import 'package:app/core/gql.dart' as _i3;
import 'package:app/core/oauth.dart' as _i4;
import 'package:app/core/service/user/user_service.dart' as _i13;
import 'package:app/core/service/wallet_connect/wallet_connect_service.dart'
    as _i14;
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
    gh.lazySingleton<_i5.EventRepository>(() => _i6.EventRepositoryImpl());
    gh.lazySingleton<_i3.MetaverseGQL>(() => _i3.MetaverseGQL());
    gh.lazySingleton<_i7.PostRepository>(() => _i8.PostRepositoryImpl());
    gh.lazySingleton<_i9.TokenRepository>(() => _i10.TokenRepositoryImpl());
    gh.lazySingleton<_i11.UserRepository>(() => _i12.UserRepositoryImpl());
    gh.lazySingleton<_i13.UserService>(() => _i13.UserService());
    gh.lazySingleton<_i14.WalletConnectService>(
        () => _i14.WalletConnectService());
    gh.lazySingleton<_i15.WalletRepository>(() => _i16.WalletRepositoryImpl());
    gh.lazySingleton<_i17.AuthBloc>(
        () => _i17.AuthBloc(userService: gh<_i13.UserService>()));
    return this;
  }
}
