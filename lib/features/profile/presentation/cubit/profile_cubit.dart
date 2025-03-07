import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zbooma_task/features/profile/data/models/profile_model.dart';
import 'package:zbooma_task/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo;

  static ProfileCubit get(context) => BlocProvider.of(context);

  void getUserData() async {
    emit(ProfileGetUserDataLoading());

    var response = await profileRepo.getUserData();

    response.fold(
      (error) {
        emit(ProfileGetUserDataError(error: error.errMessage.toString()));
      },
      (userData) {
        emit(ProfileGetUserDataSuccess(userData));
      },
    );
  }
}
