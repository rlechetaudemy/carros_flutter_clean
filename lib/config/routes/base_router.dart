import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

export 'package:fluro/fluro.dart';

typedef GetRouteCallback = Widget Function(RouteParams params);

class RouteParams {
  Map<String, dynamic> params;
  Object? object;

  RouteParams(this.params, this.object);

  int getInt(String param) => int.parse(params[param][0]);

  int getString(String param) => params[param][0];
}

abstract class BaseRouter {
  final router = new FluroRouter();

  final TransitionType transitionType;

  BaseRouter({this.transitionType = TransitionType.fadeIn});

  init();

  void add(String route, GetRouteCallback getRoute) {
    router.define(
      route,
      handler: Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        // https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
        Object? args = context != null ? ModalRoute.of(context)?.settings.arguments : null;
        return getRoute(RouteParams(params, args));
      }),
      transitionType: transitionType,
    );
  }

  void notFound(Widget page) => router.notFoundHandler = Handler(handlerFunc: (_, __) => page);

  Route<dynamic>? onGenerateRoute(RouteSettings settings) => router.generator(settings);
}
