import 'package:am_adel_market/core/utils/app_imports.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(LoginInitial());

  final AuthRepo _authRepo;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final data = await _authRepo.signInWithEmailAndPassword(
      LoginRequest(email: email, password: password),
    );
    data.fold(
      (failure) {
        emit(LoginError(failure.errMessage));
      },
      (data) {
        emit(LoginSuccess(data));
      },
    );
  }

  // Future<void> signInWithGoogle() async {
  //   emit(SignInWithGoogleLoading());
  //   final data = await _authRepo.signInWithGoogle();
  //   data.fold(
  //     (failure) {
  //       emit(SignInWithGoogleError(failure.errMessage));
  //     },
  //     (data) {
  //       emit(SignInWithGoogleSuccess());
  //     },
  //   );
  // }

  // Future<void> signInWithFacebook() async {
  //   emit(SignInWithFacebookLoading());
  //   final data = await _authRepo.signInWithFacebook();
  //   data.fold(
  //     (failure) {
  //       emit(SignInWithFacebookError(failure.errMessage));
  //     },
  //     (data) {
  //       emit(SignInWithFacebookSuccess());
  //     },
  //   );
  // }

}
