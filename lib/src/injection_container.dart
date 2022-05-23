import 'package:get_it/get_it.dart';

import 'utilities/firebase_analytics_services.dart';

final servLocator = GetIt.instance;

Future<void> init() async {
  servLocator.registerLazySingleton(() => FirebaseAnalyticsService());
}
