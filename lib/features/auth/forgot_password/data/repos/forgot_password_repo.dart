import "package:cloud_firestore/cloud_firestore.dart";
import "package:dartz/dartz.dart";
import "package:firebase_auth/firebase_auth.dart";

class ForgotPasswordRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, void>> resetPassword({required String email}) async {
    try {
      final userQuery = await _firestore
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      if (userQuery.docs.isEmpty) {
        return const Left("لا يوجد حساب مرتبط بهذا البريد الإلكتروني");
      }

      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return const Left("صيغة البريد الإلكتروني غير صحيحة");
      } else {
        return Left(e.message ?? "حدث خطأ غير متوقع، حاول مرة أخرى");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
