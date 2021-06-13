import 'package:app/config/routes/routes.dart';
import 'package:app/imports.dart';

// late NavigatorObserver mockObserver;

class MyAppTest extends StatefulWidget {
  final Widget page;

  MyAppTest(this.page);

  @override
  _MyAppTestState createState() => _MyAppTestState();
}

class _MyAppTestState extends State<MyAppTest> {
  final appRouter = get<AppRouter>();

  @override
  void initState() {
    super.initState();

    appRouter.init();
    // mockObserver = MockNavigatorObserver();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // navigatorObservers: [mockObserver],
      home: widget.page,
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
