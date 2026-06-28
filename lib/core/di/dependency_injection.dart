import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytar/core/network/network_cubit.dart';
import 'package:sytar/features/auth/forgot_password/data/repos/forgot_password_repo.dart';
import 'package:sytar/features/auth/forgot_password/manager/forgot_password_bloc.dart';
import 'package:sytar/features/auth/login/data/repos/login_repo.dart';
import 'package:sytar/features/auth/login/manager/login_bloc.dart';
import 'package:sytar/features/auth/sign_up/data/repos/signup_repo.dart';
import 'package:sytar/features/auth/sign_up/manager/signup_bloc.dart';
import 'package:sytar/features/auth/social_auth/data/repos/social_auth_repo.dart';
import 'package:sytar/features/auth/social_auth/manager/ocial_auth_bloc.dart';
import 'package:sytar/features/setup_profile/data/repos/setup_profile_repo.dart';
import 'package:sytar/features/setup_profile/manager/setup_profile_bloc.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  /// Core Services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  /// Firebase Instances
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  /// Offline Mode
  getIt.registerLazySingleton<NetworkCubit>(() => NetworkCubit());

  /// Signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo());
  getIt.registerFactory<SignupBloc>(() => SignupBloc(getIt<SignupRepo>()));

  /// Login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo());
  getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<LoginRepo>()));

  /// Forgot Password
  getIt.registerLazySingleton<ForgotPasswordRepo>(() => ForgotPasswordRepo());
  getIt.registerFactory<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(getIt<ForgotPasswordRepo>()),
  );

  // Social Auth
  getIt.registerLazySingleton<SocialAuthRepo>(() => SocialAuthRepo());
  getIt.registerFactory<SocialAuthBloc>(
    () => SocialAuthBloc(getIt<SocialAuthRepo>()),
  );

  /// Setup Profile
  getIt.registerLazySingleton<SetupProfileRepo>(() => SetupProfileRepo());
  getIt.registerFactory<SetupProfileBloc>(
    () => SetupProfileBloc(getIt<SetupProfileRepo>()),
  );
}
