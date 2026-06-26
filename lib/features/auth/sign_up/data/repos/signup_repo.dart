import "package:cloud_firestore/cloud_firestore.dart";
import "package:dartz/dartz.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:sytar/features/auth/sign_up/data/models/user_model.dart";

class SignupRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, UserModel>> userSignup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        name: name,
        email: email,
      );

      await _firestore
          .collection("users")
          .doc(userModel.uId)
          .set(userModel.toMap());

      await userCredential.user!.sendEmailVerification();

      await _firebaseAuth.signOut();

      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return const Left("كلمة المرور ضعيفة جداً");
      } else if (e.code == "email-already-in-use") {
        return const Left("البريد الإلكتروني مسجل بالفعل");
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
