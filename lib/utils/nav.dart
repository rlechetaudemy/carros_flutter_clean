import 'package:app/config/di.dart';
import 'package:app/config/routes/routes.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

BuildContext get globalContext => navigatorKey.currentState!.overlay!.context;

abstract class RouteManager {
  String? get lastPath;

  Object? get arguments;

  Future push(String path, {bool replace = false, bool clearStack = false, Object? arguments});

  bool pop<T extends Object>([T? result]);
}

class FlutterRouteManager implements RouteManager {
  String? lastPath;
  Object? arguments;

  Future push(String path, {bool replace = false, bool clearStack = false, Object? arguments}) {
    this.lastPath = path;
    this.arguments = arguments;

    AppRouter router = get<AppRouter>();
    return router.router.navigateTo(
      globalContext,
      path,
      replace: replace,
      clearStack: clearStack,
      routeSettings: RouteSettings(arguments: arguments),
    );
  }

  bool pop<T extends Object>([T? result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop(result);
      return true;
    }
    return false;
  }
}

class FlutterMockRouteManager implements RouteManager {
  String? _lastPath;
  Object? _arguments;

  String? get lastPath => _lastPath;

  Object? get arguments => _arguments;

  @override
  Future push(
    String path, {
    bool replace = false,
    bool clearStack = false,
    Object? arguments,
  }) async {
    _lastPath = path;
    _arguments = arguments;
  }

  @override
  bool pop<T extends Object>([T? result]) {
    return true;
  }
}

Future push(String path, {bool replace = false, bool clearStack = false, Object? args}) {
  final nav = get<RouteManager>();
  return nav.push(path, replace: replace, clearStack: clearStack, arguments: args);
}

bool pop<T extends Object>([T? result]) {
  final nav = get<RouteManager>();
  return nav.pop(result);
}
