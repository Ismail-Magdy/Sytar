import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/routes/routes.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_feedback_dialog.dart";
import "package:sytar/features/auth/login/presentation/widgets/login_body.dart";
import "package:sytar/features/auth/social_auth/manager/ocial_auth_bloc.dart";
import "package:sytar/features/auth/social_auth/manager/social_auth_state.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        bottom: false,
        child: BlocListener<SocialAuthBloc, SocialAuthState>(
          listener: (context, state) {
            if (state is SocialAuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CupertinoActivityIndicator()),
              );
            } else if (state is SocialAuthSuccess) {
              context.pop();

              showFeedbackDialog(
                context,
                icon: Icons.check_circle_outline_rounded,
                color: AppColors.success,
                title: "تم بنجاح",
                message: "مرحباً بك في سيطر",
                onFinish: () {
                  if (state.isProfileSetupCompleted) {
                    context.pushReplacementNamed(Routes.rootScreen);
                  } else {
                    context.pushReplacementNamed(Routes.setupProfileScreen);
                  }
                },
              );
            } else if (state is SocialAuthFailure) {
              context.pop();

              showFeedbackDialog(
                context,
                icon: Icons.error_outline_rounded,
                color: AppColors.error,
                title: "عفواً",
                message: state.errMessage,
              );
            }
          },
          child: const LoginBody(),
        ),
      ),
    );
  }
}
