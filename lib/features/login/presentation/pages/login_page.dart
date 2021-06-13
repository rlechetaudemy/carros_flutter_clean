import 'package:app/imports.dart';

class LoginPage extends StatefulWidget {
  static final loginKey = new GlobalKey<LoginPageState>();

  LoginPage() : super(key: loginKey);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> implements LoginView {
  final viewModel = get<LoginViewModel>();

  @override
  void initState() {
    super.initState();

    viewModel.view = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          key: Key('btnFake'),
          child: Text("App - Login"),
          onTap: _onClickFake,
        ),
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          AppText(
            "Login",
            "Type your login",
            stream: viewModel.validator.login$.stream,
            controller: viewModel.tLogin,
            onChanged: (s) => viewModel.setLogin(s),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 10),
          AppText(
            "Password",
            "Type your password",
            stream: viewModel.validator.password$.stream,
            controller: viewModel.tSenha,
            onChanged: (s) => viewModel.setPassword(s),
            password: true,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 20,
          ),
          AppButton(
            "Login",
            stream: viewModel.loading$.stream,
            onPressed: onClickLogin,
          )
        ],
      ),
    );
  }

  void onClickLogin() => viewModel.login();

  @override
  void onLoginSuccess() => push("/cars", replace: true);

  @override
  void onLoginError(String msg) => alert(msg);

  void _onClickFake() => viewModel.fake();

  @override
  void dispose() {
    super.dispose();
    viewModel.close();
  }
}
