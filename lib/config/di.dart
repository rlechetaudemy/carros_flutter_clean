import 'package:app/config/routes/routes.dart';
import 'package:app/features/user/data/datasources/user_local_repository_impl.dart';
import 'package:app/imports.dart';
import 'package:app/utils/rx_stream_factory.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final get = GetIt.instance;

void initGetIt({required String env}) {
  // Singletons
  get
    ..registerSingleton(AppState())
    ..registerSingleton(AppRouter());

  // Infra
  get
    ..registerLazySingleton(() => http.Client())
    ..registerFactory<RxStreamFactory>(() => AppRxStreamFactory())
    ..registerSingleton<RouteManager>(FlutterRouteManager())
    ..registerSingleton<NetworkManager>(FlutterNetworkManager(Connectivity()))
    ..registerSingleton<Prefs>(SecureStoragePrefs(FlutterSecureStorage()));

  viewModel();

  useCase();

  repository('prod' == env);

  api();
}

void useCase() {
  get
    ..registerFactory<LoginUseCase>(() => LoginUseCaseImpl(get(), get()))
    ..registerFactory(() => LogoutUseCase(get()))
    ..registerFactory(() => GetCars(get()))
    ..registerFactory(() => GetCarById(get()));
}

void viewModel() {
  get
    ..registerFactory(() => LoginViewModel(get()))
    ..registerFactory(() => LogoutViewModel(get()))
    ..registerFactory(() => CarsViewModel(get()))
    ..registerFactory(() => CarViewModel(get()));
}

void repository(bool prod) {
  get
    ..registerFactory(() => prod ? LoginRepositoryImpl(get()) : LoginRepositoryMock())
    ..registerFactory<UserLocalRepository>(() => UserLocalRepositoryImpl(get(),get()))
    ..registerFactory(() => prod ? CarRepositoryImpl(get()) : CarRepositoryMock());
}

void api() {
  get
    ..registerFactory<LoginApi>(() => LoginApiImpl(get()))
    ..registerFactory<CarApi>(() => CarApiImpl(get()));
}
