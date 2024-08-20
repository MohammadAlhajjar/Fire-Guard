import 'package:dio/dio.dart';
import 'package:fire_guard_app/core/network/network_connection_info.dart';
import 'package:fire_guard_app/src/features/auth/data/repository/sign_in_repository.dart';
import 'package:fire_guard_app/src/features/auth/data/service/sign_in_service.dart';
import 'package:fire_guard_app/src/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> setup() async {
  // ----------------<<Auth Feature Services>>-------------

  // AuthBLoc

  getIt.registerFactory(
    () => AuthBloc(
      signInRepo: getIt.call(),
    ),
  );

  // SignInRepo
  getIt.registerLazySingleton(
    () => SignInRepoImpl(
      internetConnectionInfo: getIt.call(),
      signInService: getIt.call(),
      sharedPreferences: getIt.call(),
    ),
  );

  // InternetConnectionInfo
  getIt.registerLazySingleton(
    () => InternetConnectionInfo(
      internetConnectionChecker: getIt.call(),
    ),
  );

  // SignInSrvice
  getIt.registerLazySingleton(
    () => SignInService(
      dio: getIt.call(),
    ),
  );

  // Extra
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() async {
    return await SharedPreferences.getInstance();
  });
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
