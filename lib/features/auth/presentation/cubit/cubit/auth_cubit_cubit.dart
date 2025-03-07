import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbooma_task/features/auth/data/models/auth_model.dart';
import 'package:zbooma_task/features/auth/data/repo/auth_repo.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  static AuthCubit get(context) => BlocProvider.of(context);

  void login({required String phone, required String password}) async {
    emit(AuthLoading());

    var response = await authRepo.login(phone: phone, password: password);

    response.fold(
      (error) {
        emit(AuthError(error: error.errMessage.toString()));
      },
      (loginModel) {
        emit(LoginSuccess(loginModel: loginModel));
      },
    );
  }

  void register({
    required String phone,
    required String password,
    required String name,
    required int experiences,
    required String level,
    required String address,
  }) async {
    emit(AuthLoading());

    var response = await authRepo.register(
      phone: phone,
      password: password,
      name: name,
      experiences: experiences,
      level: level,
      address: address,
    );

    response.fold(
      (error) {
        emit(AuthError(error: error.errMessage.toString()));
      },
      (registerModel) {
        emit(RegisterSuccess(registerModel: registerModel));
      },
    );
  }
}
