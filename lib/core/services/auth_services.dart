import 'package:am_adel_market/core/utils/app_imports.dart';

abstract class AuthServices {
  Future<User> createUserWithEmailAndPassword(RegisterRequest registerRequest);
  Future<User> signInWithEmailAndPassword(LoginRequest loginRequest);
//  Future<User> signInWithGoogle();
  //Future<User> signInWithFacebook();
  Future<void>deleteUser();
  Future<void>signOut();
}

class AuthWithFirebase implements AuthServices {

  @override
  Future<void> deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      RegisterRequest registerRequest,
      ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: registerRequest.email,
        password: registerRequest.password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException('كلمة المرور يجب ألا تقل عن 6 أحرف');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException('هذا البريد الإلكتروني مستخدم بالفعل');
      }
      else if (e.code == 'network-request-failed') {
        print(e.code);
        throw CustomException('لا يوجد اتصال بالإنترنت، تأكد من الشبكة');
      } else {
        print(e.code);
        throw CustomException('حدث خطأ غير متوقع، حاول مرة أخرى');
      }
    } catch (e) {
      print(e);
      throw CustomException('حدث خطأ غير متوقع، حاول مرة أخرى');
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(LoginRequest loginRequest) async{
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: loginRequest.email,
        password: loginRequest.password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw CustomException('البريد الإلكتروني أو كلمة المرور غير صحيحة');
      }
      else if (e.code == 'network-request-failed') {
        throw CustomException('لا يوجد اتصال بالإنترنت');
      } else {
        print(e.code);
        throw CustomException('حدث خطأ غير متوقع');
      }
    } catch (e) {
      print(e);
      throw CustomException('حدث خطأ غير متوقع');
    }
  }

  // @override
  // Future<User> signInWithGoogle() async {
  //   final googleSignIn = GoogleSignIn.instance;
  //
  //   await googleSignIn.initialize(
  //     serverClientId: '483648490647-htosbo706shgradj88qql1u8kd60a048.apps.googleusercontent.com'
  //   );
  //
  //   final googleUser = await googleSignIn.authenticate();
  //   final googleAuth = googleUser.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //     idToken: googleAuth.idToken,
  //   );
  //
  //   final userCredential =
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //   return userCredential.user!;
  // }

  // @override
  // Future<User> signInWithFacebook() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login(
  //     permissions: ['email', 'public_profile'],
  //   );
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider
  //       .credential(loginResult.accessToken!.tokenString);
  //   return (await FirebaseAuth.instance.signInWithCredential(
  //       facebookAuthCredential)).user!;
  // }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

}

