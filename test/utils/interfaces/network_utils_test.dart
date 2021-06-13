import 'package:connectivity/connectivity.dart';

import '../../test_imports.dart';

main() {
  late NetworkManager networkManager;
  late Connectivity connectivity;

  setUp(() {
    connectivity = MockConnectivity();
    networkManager = FlutterNetworkManager(connectivity);
  });

  void mockNetwork({required bool online}) {
    var result = online ? ConnectivityResult.mobile : ConnectivityResult.none;
    when(connectivity.checkConnectivity()).thenAnswer((_) async => result);
  }

  test("Test Online", () async {
    mockNetwork(online: true);
    expect(await networkManager.isOnline(), true);

    mockNetwork(online: false);
    expect(await networkManager.isOnline(), false);
  });

  test("Test Offline", () async {
    mockNetwork(online: false);
    expect(await networkManager.isOffline(), true);

    mockNetwork(online: true);
    expect(await networkManager.isOffline(), false);
  });
}
