import 'package:app/features/login/domain/entities/user.dart';
import 'package:app/imports.dart';
import 'package:app/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader _header(User user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(user.urlFoto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = get<AppState>().user;

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            user != null ? _header(user) : Container(),
            ListTile(
              leading: Icon(Icons.car_rental),
              title: Text("Cars"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
              subtitle: Text("help..."),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    // close drawer
    Navigator.pop(context);
    // logout
    var viewModel = get<LogoutViewModel>();
    viewModel.logout();
    // go to login
    push("/", clearStack: true);
  }
}
