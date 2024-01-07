import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di_utils.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<GetIt> configureDependencies() async => await getIt.init();
