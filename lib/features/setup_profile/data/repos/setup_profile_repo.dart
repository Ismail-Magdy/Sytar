import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetupProfileRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, void>> saveUserProfile({
    required String university,
    required String faculty,
    required String department,
    required String currentLevel,
    required String currentSemester,
    required double totalHours,
    required double completedHours,
    required double currentGpa,
    required double gpaScale,
  }) async {
    try {
      final String? uid = _firebaseAuth.currentUser?.uid;

      if (uid == null) {
        return const Left("حدث خطأ في المصادقة، يرجى تسجيل الدخول مجدداً");
      }

      await _firestore.collection("users").doc(uid).set({
        "university": university,
        "faculty": faculty,
        "department": department,
        "currentLevel": currentLevel,
        "currentSemester": currentSemester,
        "totalHours": totalHours,
        "completedHours": completedHours,
        "currentGpa": currentGpa,
        "gpaScale": gpaScale,
        "isProfileSetupCompleted": true,
      }, SetOptions(merge: true));

      return const Right(null);
    } catch (e) {
      return Left("حدث خطأ أثناء حفظ البيانات: ${e.toString()}");
    }
  }
}
