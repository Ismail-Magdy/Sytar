abstract class SocialAuthEvent {
  const SocialAuthEvent();
}

class GoogleSignInRequested extends SocialAuthEvent {}

class FacebookSignInRequested extends SocialAuthEvent {}
