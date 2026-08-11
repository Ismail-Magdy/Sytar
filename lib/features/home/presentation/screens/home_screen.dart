import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/widgets/error_screen.dart";
import "package:sytar/features/home/manager/home_cubit.dart";
import "package:sytar/features/home/manager/home_state.dart";
import "package:sytar/features/home/presentation/components/home_header.dart";
import "package:sytar/features/home/presentation/components/home_active_state.dart";
import "package:sytar/features/home/presentation/widgets/home_loading_state.dart";
import "../components/home_empty_state.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            // Loading State (Skeletonizer)
            if (state is HomeLoading) {
              return HomeLoadingState();
            }
            //
            // Error State
            else if (state is HomeError) {
              return ErrorScreen();
            }
            //
            // Success State
            else if (state is HomeSuccess) {
              final data = state.dashboardData;
              final bool isDataEmpty =
                  data.upcomingTasks.isEmpty && data.subjectsProgress.isEmpty;

              return Column(
                crossAxisAlignment: .start,
                children: [
                  //
                  Padding(
                    padding: .symmetric(horizontal: 20.w, vertical: 10.h),
                    child: HomeHeader(userName: data.userName),
                  ),
                  //
                  // Screen Content
                  Expanded(
                    child: isDataEmpty
                        ? HomeEmptyState(userName: data.userName)
                        : HomeActiveState(data: data),
                  ),
                  //
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
//200