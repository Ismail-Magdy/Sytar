import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      if (e.code == "user-not-found") {
        return const Left("هذا الحساب غير مسجل لدينا، يرجى إنشاء حساب جديد");
      } else if (e.code == "wrong-password") {
        return const Left("كلمة المرور غير صحيحة");
      } else if (e.code == "invalid-credential") {
        return const Left("بيانات الدخول غير صحيحة، أو الحساب غير مسجل");
      } else if (e.code == "invalid-email") {
        return const Left("صيغة البريد الإلكتروني غير صحيحة");
      } else if (e.code == "user-disabled") {
        return const Left("تم إيقاف هذا الحساب، يرجى التواصل مع الإدارة");
      } else if (e.code == "too-many-requests") {
        return const Left("محاولات كثيرة خاطئة، يرجى المحاولة لاحقاً");
      } else {
        return Left(e.message ?? "حدث خطأ غير متوقع، حاول مرة أخرى");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
