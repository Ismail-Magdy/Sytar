import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ErrorHandler {
  /// الدالة الرئيسية اللي بتستقبل أي خطأ وترجع رسالة لليوزر
  static String handle(dynamic error) {
    if (error is FirebaseAuthException) {
      return _handleFirebaseAuthError(error);
    } else if (error is FirebaseException) {
      return _handleFirebaseError(error);
    } else if (error is SocketException) {
      return 'لا يوجد اتصال بالإنترنت، تأكد من الشبكة وحاول مرة أخرى';
    } else if (error is TimeoutException) {
      return 'انتهى وقت الاتصال، يرجى المحاولة لاحقاً';
    } else if (error is PlatformException) {
      return 'حدث خطأ في النظام: ${error.message}';
    } else if (error is FormatException) {
      return 'حدث خطأ في معالجة البيانات';
    } else {
      return 'حدث خطأ غير متوقع، يرجى المحاولة لاحقاً';
    }
  }

  /// معالجة أخطاء المصادقة (Authentication)
  static String _handleFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'صيغة البريد الإلكتروني غير صحيحة';
      case 'user-disabled':
        return 'تم إيقاف هذا الحساب، يرجى التواصل مع الدعم';
      case 'user-not-found':
        return 'لا يوجد حساب مرتبط بهذا البريد الإلكتروني';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل في حساب آخر';
      case 'weak-password':
        return 'كلمة المرور ضعيفة، يرجى اختيار كلمة مرور أقوى';
      case 'network-request-failed':
        return 'تأكد من اتصالك بالإنترنت.';
      case 'too-many-requests':
        return 'تم حظر الحساب مؤقتاً بسبب كثرة المحاولات، جرب مرة أخرى لاحقاً';
      case 'requires-recent-login':
        return 'يرجى تسجيل الدخول مرة أخرى لإتمام هذه العملية';
      default:
        return 'حدث خطأ في تسجيل الدخول، يرجى المحاولة لاحقاً';
    }
  }

  /// معالجة أخطاء قواعد البيانات (Firestore & Storage)
  static String _handleFirebaseError(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'ليس لديك صلاحية للقيام بهذا الإجراء';
      case 'unavailable':
        return 'الخدمة غير متوفرة حالياً، تأكد من اتصالك بالإنترنت';
      case 'not-found':
        return 'البيانات المطلوبة غير موجودة';
      case 'already-exists':
        return 'هذه البيانات موجودة بالفعل';
      case 'cancelled':
        return 'تم إلغاء العملية.';
      case 'deadline-exceeded':
        return 'استغرق الطلب وقتاً طويلاً، حاول مرة أخرى';
      default:
        return 'حدث خطأ في الاتصال بالخادم';
    }
  }
}
