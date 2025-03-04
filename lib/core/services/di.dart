import 'package:get_it/get_it.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  // Cubits
  // sl.registerFactory<AuthCubit>(() => AuthCubit(sl(), sl()));

  //* Repository
  // sl.registerLazySingleton<AuthRepository>(
  //     () => FirebaseUserRepositoryImpl(userDataSource: sl()));

  //* Datasources
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //     () => AuthRemoteDataSourceImpl(sl()));

  //! External
  // sl.registerLazySingleton(() => DioClient(sl()));
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => TaskPreferences(sharedPref));
}
