import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/features/auth/data/repo/auth_repo.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  // Cubits
  // sl.registerFactory<AuthCubit>(() => AuthCubit(sl(), sl()));

  //* Repository
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());

  //! External
  // sl.registerLazySingleton(() => DioClient(sl()));
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPref);
  sl.registerLazySingleton(() => TaskPreferences(sharedPref));
}
