import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbooma_task/features/auth/data/models/login_model.dart';
import 'package:zbooma_task/features/auth/data/repo/auth_repo.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  static AuthCubit get(context) => BlocProvider.of(context);

  void login({required String phone, required String password}) async {
    emit(LoginLoading());

    var response = await authRepo.login(phone: phone, password: password);

    response.fold(
      (error) {
        emit(LoginError(error: error.errMessage.toString()));
      },
      (loginModel) {
        emit(LoginSuccess(loginModel: loginModel));
      },
    );
  }
}
