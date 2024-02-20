import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final locator = GetIt.instance;

@InjectableInit()
void Function({String? environment, EnvironmentFilter? environmentFilter}) configureDependencies = ({
  String? environment = Environment.prod,
  EnvironmentFilter? environmentFilter,
}) =>
    locator.init(environment: environment, environmentFilter: environmentFilter);