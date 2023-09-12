import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:app/injection/register_module.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void registerModule() => getIt.init();
