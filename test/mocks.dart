import 'package:app/imports.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

// @GenerateMocks([], customMocks: [MockSpec<NavigatorObserver>(returnNullOnMissingStub: true)])
@GenerateMocks([NetworkManager, Connectivity, FlutterSecureStorage])
@GenerateMocks([http.Client])
@GenerateMocks([Prefs])
@GenerateMocks([CarsViewModel, CarViewModel, GetCars, GetCarById, CarRepository, CarApi])
@GenerateMocks([LoginViewModel, LoginView, LoginUseCase, LoginRepository, LoginApi])
@GenerateMocks([LogoutViewModel, LogoutUseCase])
@GenerateMocks([UserLocalRepository])
@GenerateMocks([ViewState])
main() {}
