import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

import '../../../../core/services/notification_services.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthServices _authServices;
  final DatabaseServices _databaseServices;


  AuthRepoImpl(this._authServices, this._databaseServices);


  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      RegisterRequest registerRequest,
      ) async {
    User? user;

    try {
      user = await _authServices.createUserWithEmailAndPassword(
        registerRequest,
      );

      final userEntity = UserEntity(
        userName: registerRequest.userName,
        email: registerRequest.email,
        uId: user.uid,
        phone: registerRequest.phone,
        password: registerRequest.password,
        createdAt: DateTime.now(),
      );

      await addData(userEntity);
      await saveUserData(userEntity);
      await CacheHelper.saveData(
        key: 'uId',
        value: user.uid,
      );
      Constants.uId = user.uid;
      await NotificationServices.saveFcmToken();

      return Right(userEntity);
    } catch (e) {
      if (user != null) {
        await _authServices.deleteUser();
        print(e);
      }
print(e);
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      LoginRequest loginRequest) async {
    try {
      final user = await _authServices.signInWithEmailAndPassword(loginRequest);

      final data = await getUserData(uId: user.uid);

      await saveUserData(data);

      await CacheHelper.saveData(
        key: 'uId',
        value: data.uId,
      );

      Constants.uId = data.uId;
      await NotificationServices.saveFcmToken();

      return Right(data);
    } on Exception catch (e) {
      print(e);
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
  //
  // @override
  // Future<Either<Failure, UserEntity>> signInWithGoogle() async {
  //   try {
  //     final user = await _authServices.signInWithGoogle();
  //     return Right(
  //         UserModel.fromFirebaseUser(user)
  //     );
  //   } on GoogleSignInException catch (e) {
  //     if (e.code == GoogleSignInExceptionCode.canceled) {
  //       return Left(
  //           ServerFailure(errMessage: 'تم إلغاء تسجيل الدخول من قبل المستخدم'));
  //     } else {
  //       return Left(ServerFailure(errMessage: 'حدث خطأ أثناء تسجيل الدخول'));
  //     }
  //   }
  // }

  // @override
  // Future<Either<Failure, UserEntity>> signInWithFacebook() async {
  //   try {
  //     final user = await _authServices.signInWithFacebook();
  //     return Right(
  //         UserModel.fromFirebaseUser(user)
  //     );
  //   } catch (e) {
  //     // if (e.code == GoogleSignInExceptionCode.canceled) {
  //     //   return Left(ServerFailure(errMessage: 'تم إلغاء تسجيل الدخول من قبل المستخدم'));
  //     // } else {
  //     // return Left(ServerFailure(errMessage: 'حدث خطأ أثناء تسجيل الدخول'));
  //     return Left(ServerFailure(errMessage: e.toString()));
  //     //}
  //   }
  // }

  @override
  Future<void> addData(UserEntity user) async {
    await _databaseServices.addData
      (
      path: 'users',
      data: UserModel.fromEntity(user).toJson(),
      uId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    var user = await _databaseServices.getData(path: 'users', uId: uId);
    return UserModel.fromJson(user);
  }

  @override
  Future saveUserData(UserEntity user) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toJson());
    return await CacheHelper.saveData(key: 'userData', value: jsonData);
  }


  @override
  Future<Either<Failure, void>> deleteAccount(String password) async {
    try {

      await _databaseServices.reAuthenticate(
        email: getUser().email,
        password: password,
      );
      await _databaseServices.deleteData(
        path: 'users',
        uId: getUser().uId,
      );
      await _authServices.deleteUser();
      await CacheHelper.removeData(key: 'uId');
      await CacheHelper.removeData(key: 'userData');
      await CacheHelper.removeData(key: 'onBoarding');



      return right(null);
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in delete account is $e');
      return left(ServerFailure(errMessage: 'كلمه السر غير صحيحه'));
    } catch (e) {
      print('Exception in delete account is $e');
      return left(ServerFailure(errMessage: e.toString(),));
    }
  }

  @override
  Future<void> signOut() async {
    await _authServices.signOut();
    await CacheHelper.removeData(key: 'uId');
    await CacheHelper.removeData(key: 'userData');
  }

  @override
  Future<Either<Failure, void>> updateUser(UserEntity userEntity,) async {
    try {
      await _databaseServices.updateData(
          path: 'users',
          data:{
            'userName': userEntity.userName,
            'phone': userEntity.phone,
          },
          docId: userEntity.uId
      );
      return Right(null);
    } on Exception catch (e) {
      print(e);
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
