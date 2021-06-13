import 'package:app/config/routes/routes.dart';

import 'imports.dart';

void main() {
  // R.load(Locale("en","us"));

  initGetIt(env: Env.prod);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = get<AppRouter>();

  @override
  void initState() {
    super.initState();

    appRouter.init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
