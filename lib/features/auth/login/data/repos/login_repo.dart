import "package:dartz/dartz.dart";
import "package:firebase_auth/firebase_auth.dart";

class LoginRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Either<String, UserCredential>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (!userCredential.user!.emailVerified) {
        await _firebaseAuth.signOut();
        return const Left(
          "يرجى التحقق من صندوق الوارد وتفعيل بريدك الإلكتروني أولاً",
        );
      }

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential" ||
          e.code == "user-not-found" ||
          e.code == "wrong-password") {
        return const Left("البريد الإلكتروني أو كلمة المرور غير صحيحة");
      } else if (e.code == "invalid-email") {
        return const Left("صيغة البريد الإلكتروني غير صحيحة");
      } else {
        return Left(e.message ?? "حدث خطأ غير متوقع، حاول مرة أخرى");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
