import 'package:app/config/di.dart';
import 'package:app/config/routes/routes.dart';
import 'package:app/imports.dart';
import 'package:app/core/plugins/network_utils.dart';
import 'package:app/utils/rx_stream_factory.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

initGetItTest() {
  // Singletons
  get..registerSingleton(AppState())..registerSingleton(AppRouter());

  var networkManager = MockNetworkManager();
  when(networkManager.isOnline()).thenAnswer((_) async => true);
  when(networkManager.isOffline()).thenAnswer((_) async => false);

  // Infra
  get
    ..registerSingleton<Prefs>(MockPrefs())
    ..registerFactory<NetworkManager>(() => networkManager)
    ..registerFactory<RxStreamFactory>(() => TestRxStreamFactory())
    ..registerSingleton<RouteManager>(FlutterMockRouteManager());
}
