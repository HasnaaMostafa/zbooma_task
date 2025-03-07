import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zbooma_task/core/preferences/shared_pref.dart';
import 'package:zbooma_task/features/auth/data/repo/auth_repo.dart';
import 'package:zbooma_task/features/home/data/repo/task_repo.dart';
import 'package:zbooma_task/features/profile/data/repo/profile_repo.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  // Cubits

  //* Repository
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(sl()));
  sl.registerLazySingleton<TaskRepo>(() => TaskRepoImpl(sl()));

  //! External
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPref);
  sl.registerLazySingleton(() => TaskPreferences(sharedPref));
}
