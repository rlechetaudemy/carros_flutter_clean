import 'package:app/config/routes/not_found_page.dart';
import 'package:app/imports.dart';

import 'base_router.dart';

class AppRouter extends BaseRouter {
  AppRouter() : super(transitionType: TransitionType.fadeIn);

  void init() {
    add("/", (_) => LoginPage());
    add("/cars", (_) => CarsPage());
    add("/cars/car", (args) => CarPage(args.object as Car));
    add("/cars/:id", (args) => CarByIdPage(args.getInt("id")));

    notFound(NotFoundRoutePage());
  }
}
