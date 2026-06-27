import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // تسجيل الدخول بجوجل
  Future<Either<String, UserCredential>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return const Left("تم إلغاء عملية تسجيل الدخول");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? "حدث خطأ أثناء التسجيل بجوجل");
    } catch (e) {
      return Left(e.toString());
    }
  }

  // تسجيل الدخول بفيسبوك
  Future<Either<String, UserCredential>> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );

        final userCredential = await _firebaseAuth.signInWithCredential(
          credential,
        );

        return Right(userCredential);
      } else if (result.status == LoginStatus.cancelled) {
        return const Left("تم إلغاء عملية تسجيل الدخول");
      } else {
        return Left(result.message ?? "حدث خطأ أثناء التسجيل بفيسبوك");
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.message ?? "حدث خطأ في مصادقة فيسبوك");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
