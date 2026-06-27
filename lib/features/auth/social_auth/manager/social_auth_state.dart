abstract class SocialAuthState {
  const SocialAuthState();
}

class SocialAuthInitial extends SocialAuthState {}

class SocialAuthLoading extends SocialAuthState {}

class SocialAuthSuccess extends SocialAuthState {
  final bool isProfileSetupCompleted;

  const SocialAuthSuccess({required this.isProfileSetupCompleted});
}

class SocialAuthFailure extends SocialAuthState {
  final String errMessage;

  const SocialAuthFailure({required this.errMessage});
}
