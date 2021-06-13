import 'package:app/config/di.dart';
import 'package:connectivity/connectivity.dart';

abstract class NetworkManager {
  Future<bool> isOffline();

  Future<bool> isOnline();
}

class FlutterNetworkManager extends NetworkManager {
  Connectivity connectivity;

  FlutterNetworkManager(this.connectivity);

  Future<bool> isOffline() async {
    return !await isOnline();
  }

  Future<bool> isOnline() async {
    var connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    return true;
  }
}

Future<bool> isOffline() {
  final c = get<NetworkManager>();
  return c.isOffline();
}
