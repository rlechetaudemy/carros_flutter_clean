import 'package:app/imports.dart';

import 'nav.dart';

alert(String msg, {Function? callback}) {
  showDialog(
    context: globalContext,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(R.strings.cars),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                callback?.call();
              },
            )
          ],
        ),
      );
    },
  );
}
