// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/core/application/auth/auth_bloc.dart' as _i8;
import 'package:app/core/data/event/repository/event_repository_impl.dart'
    as _i7;
import 'package:app/core/domain/event/event_repository.dart' as _i6;
import 'package:app/core/gql.dart' as _i3;
import 'package:app/core/oauth.dart' as _i4;
import 'package:app/core/service/auth/auth_service.dart' as _i5;
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
    gh.lazySingleton<_i6.EventRepository>(() => _i7.EventRepositoryImpl());
    gh.lazySingleton<_i8.AuthBloc>(
        () => _i8.AuthBloc(authService: gh<_i5.AuthService>()));
    return this;
  }
}
